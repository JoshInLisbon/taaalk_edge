class TlkRequestsController < ApplicationController
  require 'digest/md5'
  include SpkrMaker

  before_action :set_tlk_request, :set_requesting_user, :set_requested_user
  skip_before_action :authenticate_user!, only: :show

  def show

  end

  def accept
    if current_user == @requested_user
      @tlk = Tlk.new(title: @tlk_request.title)
      @tlk.user = @requesting_user
      @tlk.invite_code = '%010d' % rand(100000..999999)
      @tlk.msg_key = Digest::MD5.hexdigest(@tlk.title)
      if @tlk.save!
        @requesting_spkr = make_remote_spkr(@requesting_user)
        make_spkr
        make_msg
        @tlk_request.destroy
        send_both_user_followers_new_tlk_mail(@requesting_user, @requested_user, @tlk)
        redirect_to show_tlk_path(@tlk)
      end
    else
      flash[:notice] = "You need to be logged in as the requested user to accept the Taaalk."
      redirect_to tlk_request_path(@tlk_request)
    end
  end

  def reject
    raise
  end

  private

  def set_tlk_request
    @tlk_request = TlkRequest.friendly.find(params[:id])
  end

  def set_requesting_user
    @requesting_user = User.find(@tlk_request.requesting_user_id)
  end

  def set_requested_user
    @requested_user = User.find(@tlk_request.requested_user_id)
  end

  def make_msg
    @msg = Msg.new(
      tlk: @tlk,
      content: @tlk_request.first_msg,
      spkr: @requesting_spkr,
      user: @requesting_user
    )
    @msg.save!
  end

  def send_both_user_followers_new_tlk_mail(requesting_user, requested_user, tlk)
    requesting_user.followers.each do |follower|
      mail = TlkMailer.with(
        tlk: tlk, followed_user: requesting_user,
        follower: follower
      ).new_tlk_update_user_follower
      mail.deliver_later
    end

    requested_user.followers.each do |follower|
      mail = TlkMailer.with(
        tlk: tlk, followed_user: requested_user,
        follower: follower
      ).new_tlk_update_user_follower
      mail.deliver_later
    end
  end

end

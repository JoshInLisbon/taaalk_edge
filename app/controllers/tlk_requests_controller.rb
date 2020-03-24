class TlkRequestsController < ApplicationController
  require 'digest/md5'
  include SpkrMaker

  before_action :set_tlk_request, :set_requesting_user, :set_requested_user
  skip_before_action :authenticate_user!, only: :show

  def show
    @title = "Taaalk request from #{@requesting_user.username}"
    @requesting_user_color = %w(green purple red orange black pink white blue yellow).sample
    @requested_user_color = %w(green purple red orange black pink white blue yellow).sample
  end

  def accept
    if current_user == @requested_user
      @new_tlk = Tlk.new(title: @tlk_request.title)
      @new_tlk.user = @requesting_user
      @new_tlk.invite_code = '%010d' % rand(100000..999999)
      @new_tlk.msg_key = Digest::MD5.hexdigest(@new_tlk.title)
      if @new_tlk.save!
        @requesting_spkr = make_remote_spkr(@requesting_user)
        @tlk = Tlk.find(@new_tlk.id)
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
    if current_user == @requested_user
      redirect_to root_path
    else
      flash[:notice] = "You need to be logged in as the requested user to reject the Taaalk request."
      redirect_to tlk_request_path(@tlk_request)
    end
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
      content: "<div class='tlk-bubble-holder'><div class='tlk-bubble'>#{@tlk_request.first_msg}</div></div>",
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

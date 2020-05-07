class TlksController < ApplicationController
  require 'digest/md5'
  include SpkrMaker

  skip_before_action :authenticate_user!, only: [:index, :show, :new]

  def index
    @tlks = Tlk.includes(:spkrs).paginate(page: params[:page], per_page: 30).order(updated_at: :desc)
    @title = "The home of public conversations"
  end

  def newly_created
    @tlks = Tlk.includes(:spkrs).paginate(page: params[:page], per_page: 30).order(created_at: :desc)
    @title = "The home of public conversations"
  end

  def show
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
    @msgs = @tlk.msgs.sort_by(&:created_at)
    @title = "#{@tlk.title} - #{spkr_names}"
    @user_spkrs = Spkr.where(tlk: @tlk, user: current_user, hide: false).sort_by(&:created_at)
    @msg = Msg.new()
    new_spkr_on_invite
    user_is_spkr_only? if current_user.present?
    updated_at = @tlk.updated_at
    view_count = @tlk.views += 1
    @tlk.update_columns(views: view_count, updated_at: updated_at)
  end

  def new
    @tlk = Tlk.new()
    @title = "Start a conversation"
    @tlk_with_me_users = User.joins(:rich_text_tlk_with_me).paginate(page: params[:page], per_page: 30).order(updated_at: :desc)
    if current_user.present?
      @twm_present = current_user.tlk_with_me.present? ? true : false
    end
  end

  def edit
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
  end

  def create
    # If making changes, this method also exists in TlkRequestsController
    @tlk = Tlk.new(tlk_params)
    @tlk.user = current_user
    @tlk.invite_code = '%010d' % rand(100000000..999999999)
    @tlk.msg_key = Digest::MD5.hexdigest(@tlk.title)
    if @tlk.save!
      make_spkr
      send_tlk_user_tlk_created_mail
      send_user_followers_new_tlk_mail
      redirect_to show_tlk_path(@tlk), flash: { edit: true }
    end
  end

  def update
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
    @tlk.update(tlk_params)
    respond_to do |format|
      format.js { render 'update', layout: false } # { @tlk }# <-- will render `app/views/reviews/create.js.erb`
      format.html { redirect_to new_tlk_path(@tlk) }
    end
  end

  def destroy
    @tlk = Tlk.friendly.find(params[:id])
    if current_user.valid_password?(password_param[:password]) && @tlk.user == current_user
      @tlk.destroy
      redirect_to root_path
      flash[:notice] = "Your Taaalk has been deleted."
    else
      redirect_to show_tlk_path(@tlk)
      flash[:notice] = "Password not correct."
    end
  end

  private

  def spkr_names
    spkr_name_list = ""
    @tlk.spkrs.each_with_index do |spkr, i|
      if @tlk.spkrs.length == 1
        spkr_name_list << spkr.name
      elsif i + 2 == @tlk.spkrs.length
        spkr_name_list << "#{spkr.name} "
      elsif i + 1 == @tlk.spkrs.length
        spkr_name_list << "& #{spkr.name}"
      else
        spkr_name_list << "#{spkr.name}, "
      end
    end
    spkr_name_list
  end

  def password_param
    params.require(:tlk).permit(:password)
  end

  def tlk_params
    params.require(:tlk).permit(:title, :image)
  end

  def new_spkr_on_invite
    @spkr = Spkr.new() if flash[:invited]
  end

  def user_is_spkr_only?
    @tlk.spkrs.each do |spkr|
      @spkr_only = true if spkr.user == current_user && @tlk.user != current_user
    end
  end

  def send_tlk_user_tlk_created_mail
    mail = TlkMailer.with(
      tlk: @tlk,
      user: current_user
    ).tlk_user_tlk_created
    mail.deliver_later
  end

  def send_user_followers_new_tlk_mail
    current_user.followers.each do |follower|
      mail = TlkMailer.with(
        tlk: @tlk,
        followed_user: current_user,
        follower: follower
      ).new_tlk_update_user_follower
      mail.deliver_later
    end
  end
end

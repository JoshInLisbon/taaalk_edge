class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_user, only: [:show, :edit, :update, :tlk_with_request, :destroy_tlk_with_me]

  def show
    @title = "(User) #{@user.username}"
    set_user_tlks
  end

  def edit
    @title = "Edit your details"
  end

  def update
    @user.update!(user_params)
    redirect_to show_user_path(@user)
  end

  def tlk_with_me
    current_user.update!(user_params)
    redirect_to new_tlk_path
  end

  def tlk_with_request
    @tlk_request = TlkRequest.new()
    @title = "Request to Taaalk with #{@user.username}"
  end

  def send_tlk_request
    create_tlk_request
    update_user_profile_with_tlk_request
    send_tlk_request_mail
    flash[:notice] = "Your request has been sent. You will get an email if the request is accepted."
    redirect_to new_tlk_path
  end

  def destroy_tlk_with_me
    @user.tlk_with_me.destroy
    redirect_to new_tlk_path
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def set_user_tlks
    user_tlks = []
    user_tlks_ids = []
    @user.spkrs.each do |spkr|
      unless user_tlks_ids.include?(spkr.tlk.id)
        user_tlks_ids << spkr.tlk.id
        user_tlks << spkr.tlk
      end
    end
    @user_tlks = user_tlks.sort! { |a,b| b.updated_at <=> a.updated_at }
  end

  def user_params
    params.require(:user).permit(:image, :username, :bio, :biog, :email, :tlk_with_me)
  end

  def tlk_request_user_params
    params.require(:user).permit(:tlk_with_you)
  end

  def tlk_request_params
    params.require(:tlk_request).permit(:title, :first_msg)
  end

  def create_tlk_request
    @requested_user = User.friendly.find(params[:id])
    @requesting_user = current_user
    @tlk_request = TlkRequest.new(tlk_request_params)
    @tlk_request.tlk_with_you = tlk_request_user_params[:tlk_with_you]
    @tlk_request.requesting_user_id = @requesting_user.id
    @tlk_request.requested_user_id = @requested_user.id
    @tlk_request.key = rand(100000..999999)
    @tlk_request.save!
  end

  def update_user_profile_with_tlk_request
    unless current_user.tlk_with_you.present?
      current_user.tlk_with_you = tlk_request_user_params[:tlk_with_you]
      current_user.save!
    end
  end

  def send_tlk_request_mail
    mail = TlkMailer.with(
      tlk_request: @tlk_request,
      requested_user: @requested_user,
      requesting_user: @requesting_user
    ).tlk_request
    mail.deliver_later
  end
end

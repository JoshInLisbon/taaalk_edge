class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_user, only: [:edit, :update, :tlk_with_request]

  def show
    @user = User.includes(:tlks).friendly.find(params[:id])
  end

  def edit
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
  end

  def send_tlk_request
    create_tlk_request
    update_user_profile_with_tlk_request
    send_tlk_request_mail
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
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

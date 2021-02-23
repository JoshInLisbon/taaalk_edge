require 'action_view'

class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_user, only: [:show, :edit, :tlk_with_request, :destroy_tlk_with_me, :destroy_tlk_with_me_user_page, :destroy]
  include ActionView::Helpers::SanitizeHelper

  def show
    # test
    @title = "(User) #{@user.username}"
    @nav = "user" if @user == current_user
    set_user_tlks
  end

  def edit
    @title = "Edit your details"
  end

  def update
    @old_name = current_user.username
    @old_biog = strip_tags(current_user.biog.to_s)
    @new_name = user_params[:username]
    @new_biog = user_params[:biog]
    if user_twm_params[:tlk_with_me].present?
      current_user.tlk_with_me = user_twm_params[:tlk_with_me]
    end
    current_user.update!(user_params)
    spkrs_update_after_user_update
    redirect_to show_user_path(current_user)
  end

  def tlk_with_me
    current_user.update!(user_params_twm_new_page)
    redirect_to new_tlk_path
  end

  def tlk_with_request
    @tlk_request = TlkRequest.new()
    @title = "Request to Taaalk with #{@user.username}"
  end

  def send_tlk_request
    if tlk_request_user_params[:tlk_with_you].present? && tlk_request_params[:title].present? && tlk_request_params[:first_msg].present?
      create_tlk_request
      update_user_profile_with_tlk_request
      send_tlk_request_mail
      flash[:notice] = "Your request has been sent. You will get an email if the request is accepted."
      redirect_to new_tlk_path
    else
      flash[:notice] = "You must complete all fields to send a Taaalk request."
      redirect_to tlk_with_request_path(User.friendly.find(params[:id]))
    end

  end

  def destroy_tlk_with_me
    current_user.tlk_with_me.destroy
    redirect_to new_tlk_path
  end

  def destroy_tlk_with_me_user_page
    current_user.tlk_with_me.destroy
    redirect_to show_user_path
  end

  def destroy
    if current_user.destroy_with_password(password_param[:password])
      redirect_to root_path
      flash[:notice] = "Your account has been deleted."
    else
      redirect_to show_user_path
      flash[:notice] = "Password not correct."
    end
  end

  def update_password
    current_password = update_password_params[:current_password]
    new_password = update_password_params[:new_password]
    confirm_new_password = update_password_params[:confirm_new_password]
    if current_user.valid_password?(current_password)
      if current_user.reset_password(new_password, confirm_new_password)
        redirect_to show_user_path(current_user)
        flash[:notice] = "Your password has been updated. You need to log in again."
      else
        redirect_to show_user_path(current_user)
        flash[:notice] = "Your new password and its confirmation didn't match."
      end
    else
      redirect_to show_user_path(current_user)
      flash[:notice] = "Your current password was entered incorrectly."
    end
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
    params.require(:user).permit(:image, :username, :bio, :biog, :email, :tlk_with_you, :password_for_delete, :twitter_handle)
  end

  def user_params_twm_new_page
    params.require(:user).permit(:image, :username, :tlk_with_me)
  end

  def user_twm_params
    params.require(:user).permit(:tlk_with_me)
  end

  def password_param
    params.require(:user).permit(:password)
  end

  def update_password_params
    params.require(:user).permit(:current_password, :new_password, :confirm_new_password)
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

  def spkrs_update_after_user_update
    current_user.spkrs.each do |spkr|
      if spkr.name == @old_name
        spkr.name = @new_name
        spkr.biog = @new_biog if strip_tags(spkr.biog.to_s) == @old_biog || !spkr.biog.present?
        spkr.save!
      end
    end
  end
end

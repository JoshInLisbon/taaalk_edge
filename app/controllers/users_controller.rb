class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_user, only: [:edit, :update]

  def show
    @user = User.includes(:tlks).friendly.find(params[:id])
  end

  def edit
  end

  def update
    @user.update!(user_params)
    redirect_to show_user_path(@user)
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:image, :username, :bio, :biog, :email)
  end
end

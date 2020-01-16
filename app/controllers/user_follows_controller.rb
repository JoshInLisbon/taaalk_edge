class UserFollowsController < ApplicationController
  before_action :set_user
  skip_before_action :authenticate_user!, only: :create

  def create
    if current_user.present?
      UserFollow.create!(
        follower: current_user,
        followed_user: @user
      )
      respond_to do |format|
        format.js { render 'create', layout: false }
      end
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    follow = UserFollow.find_by(follower: current_user, followed_user: @user)
    follow.destroy
    respond_to do |format|
      format.js { render 'destroy', layout: false }
    end
  end

  private

  def followed_user_param
    params.permit(:user_id)
  end

  def set_user
    @user = User.find(followed_user_param[:user_id])
  end
end

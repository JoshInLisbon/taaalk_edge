class TlkFollowsController < ApplicationController
  before_action :set_tlk
  skip_before_action :authenticate_user!, only: :create

  def create
    if current_user.present?
      follow = TlkFollow.create!(
        tlk: @tlk,
        user: current_user
      )
      respond_to do |format|
        format.js { render 'create', layout: false }
      end
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    follow = TlkFollow.find_by(user: current_user, tlk: @tlk)
    follow.destroy
    respond_to do |format|
      format.js { render 'destroy', layout: false }
    end
  end

  private

  def set_tlk
    @tlk = Tlk.friendly.find(params[:tlk_id])
  end
end

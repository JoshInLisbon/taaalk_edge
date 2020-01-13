class TlkFollowsController < ApplicationController
  before_action :set_tlk

  def create
    TlkFollow.create!(
      tlk: @tlk,
      user: current_user
    )
    # if spkrs_follow == "true"
    #   @tlk.spkrs.each do |spkr|

    #   end
    # end
    respond_to do |format|
      format.js { render 'create', layout: false }
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

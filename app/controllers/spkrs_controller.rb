class SpkrsController < ApplicationController
  before_action :set_spkr

  def update
    @spkr.update(spkr_params)
    complete_user_profile
    respond_to do |format|
      format.js # { @tlk }# <-- will render `app/views/reviews/create.js.erb`
      format.html { redirect_to new_tlk_path(@tlk) }
    end
  end

  def destroy
    @spkr.destroy
    redirect_to show_tlk_path(@spkr.tlk)
  end

  def hide_spkr
    @spkr.hide = true
    @spkr.save!
    redirect_to show_tlk_path(@spkr.tlk)
  end

  private

  def set_spkr
    @spkr = Spkr.find(params[:id])
  end

  def spkr_params
    params.require(:spkr).permit(:name, :bio)
  end

  def complete_user_profile
    current_user.update_attributes(username: spkr_params[:name]) unless current_user.username.present?
    current_user.update_attributes(bio: spkr_params[:bio]) unless current_user.bio.present?
  end
end

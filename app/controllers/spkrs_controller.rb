class SpkrsController < ApplicationController
  before_action :set_spkr

  def update
    @spkr.update(spkr_params)
    respond_to do |format|
      format.js # { @tlk }# <-- will render `app/views/reviews/create.js.erb`
      format.html { redirect_to new_tlk_path(@tlk) }
    end
  end

  private

  def set_spkr
    @spkr = Spkr.find(params[:id])
  end

  def spkr_params
    params.require(:spkr).permit(:name, :bio)
  end
end

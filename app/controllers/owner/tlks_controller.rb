class Owner::TlksController < ApplicationController
  def show
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
  end
end


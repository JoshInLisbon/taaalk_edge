class Invite::TlksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :invited?]

  def show
    @tlk = Tlk.includes(:spkrs).friendly.find(params[:id])
  end

  def invited?
    if
  end

  private

  def invited_parms

  end
end

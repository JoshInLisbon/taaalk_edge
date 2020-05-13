class Invite::TlksController < ApplicationController
  include SpkrMaker

  skip_before_action :authenticate_user!, only: [:show, :invited?]

  def show
    @tlk = Tlk.friendly.find(params[:id])
    @msgs = @tlk.msgs.sort_by(&:created_at)
    @title = "(Invitation) #{@tlk.title}"
  end

  def invited?
    @tlk = Tlk.friendly.find(invited_params[:id])
    if invited_params[:key].to_i == @tlk.invite_code
      if current_user.present?
        make_spkr
        redirect_to show_tlk_path(@tlk), flash: { edit: true }
        flash[:notice] = "You are now a member of this Taaalk."
      else
        redirect_to show_tlk_path(@tlk), flash: { invited: true }
        flash[:notice] = "Correct code. You must sign up / log in now to join the Taaalk."
      end
    else
      respond_to do |format|
        format.js { render 'invited', layout: false } # { @tlk }# <-- will render `app/views/reviews/create.js.erb`
        format.html { redirect_to invited_to_tlk_path(@tlk) }
      end
    end
  end

  private

  def invited_params
    params.require(:tlk).permit(:key, :id)
  end
end

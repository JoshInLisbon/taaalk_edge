class Invite::TlksController < ApplicationController
  include SpkrMaker

  skip_before_action :authenticate_user!, only: [:show, :invited?]

  def show
    @tlk = Tlk.friendly.find(params[:id])
    @title = "(Invitation) #{@tlk.title}"
  end

  def invited?
    @tlk = Tlk.friendly.find(invited_params[:id])
    if invited_params[:key].to_i == @tlk.invite_code
      if current_user.present?
        make_spkr
        send_tlk_spkr_tlk_joined_mail
        send_tlk_owner_spkr_joined_mail
        redirect_to show_tlk_path(@tlk), flash: { edit: true }
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

  def send_tlk_spkr_tlk_joined_mail
    mail = TlkMailer.with(
      tlk: @tlk,
      user: current_user
    ).tlk_spkr_tlk_joined
    mail.deliver_later
  end

  def send_tlk_owner_spkr_joined_mail
    mail = TlkMailer.with(
      tlk: @tlk,
      user: @tlk.user,
      joined_user: current_user
    ).tlk_owner_tlk_joined
    mail.deliver_later
  end
end

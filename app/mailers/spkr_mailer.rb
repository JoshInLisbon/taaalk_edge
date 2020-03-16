class SpkrMailer < ApplicationMailer
  before_action :spkr_mailer_params

  def edited_spkr
    mail(
      to: "#{@spkr.name} <#{@spkr.user.email}>",
      subject: "#{@editing_spkr.name} has edited your details in '#{@tlk.title}'. Please confirm or reject this edit."
    )
  end

  def accept_edit
    mail(
      to: "#{@editing_spkr.name} <#{@editing_spkr.user.email}>",
      subject: "#{@spkr.name} has accepted your profile edit suggestions in '#{@tlk.title}'."
    )
  end

  def reject_edit
    mail(
      to: "#{@editing_spkr.name} <#{@editing_spkr.user.email}>",
      subject: "#{@editing_spkr.name} has edited your details in '#{@tlk.title}'. Please confirm or reject this edit."
    )
  end

  private

  def spkr_mailer_params
    @spkr = params[:spkr]
    @editing_spkr = params[:editing_spkr]
    @tlk = params[:tlk]
  end

end

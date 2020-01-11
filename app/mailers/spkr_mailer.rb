class SpkrMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.spkr_mailer.edited_spkr.subject
  #
  def edited_spkr
    @spkr = params[:spkr]
    @editing_user = params[:editing_user]
    @tlk = params[:tlk]

    mail(to: "#{@spkr.user.email}", subject: "Taaalk: #{@editing_user.username} has edited your details in '#{@tlk.title}'. Please confirm or reject this edit.")
  end
end

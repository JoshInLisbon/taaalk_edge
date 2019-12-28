class NewSpkrMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_spkr_mailer.welcome.subject
  #
  def welcome
    @new_spkr = params[:new_spkr]
    @tlk = params[:tlk]
    mail(to: @new_spkr[:email], subject: "Invite to Taaalk from #{@tlk.user.username}")
  end
end

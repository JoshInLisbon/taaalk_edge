# Preview all emails at http://localhost:3000/rails/mailers/new_spkr_mailer
class NewSpkrMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/new_spkr_mailer/welcome
  def welcome
    NewSpkrMailer.welcome
  end

end

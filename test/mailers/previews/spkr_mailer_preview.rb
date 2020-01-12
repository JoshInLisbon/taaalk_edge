# Preview all emails at http://localhost:3000/rails/mailers/spkr_mailer
class SpkrMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/spkr_mailer/edited_spkr
  def edited_spkr
    SpkrMailer.edited_spkr
  end

end

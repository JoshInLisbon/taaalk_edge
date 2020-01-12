class SpkrMailer < ApplicationMailer
  def edited_spkr
    @spkr = params[:spkr]
    @editing_spkr = params[:editing_spkr]
    @tlk = params[:tlk]

    mail(
      to: @spkr.user.email,
      subject: "#{@editing_spkr.name} has edited your details in '#{@tlk.title}'. Please confirm or reject this edit."
    )
  end
end

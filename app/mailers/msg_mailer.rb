class MsgMailer < ApplicationMailer
  def new_msg_update_spkr
    @spkr = params[:spkr]
    @msg = params[:msg]
    @tlk = params[:tlk]

    mail(
      to: @spkr.user.email,
      subject: "#{@tlk.title}: New message. Read it and reply."
    )
  end
end

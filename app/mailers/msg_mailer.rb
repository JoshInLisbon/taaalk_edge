class MsgMailer < ApplicationMailer
  def new_msg_update_spkr
    @spkr = params[:spkr]
    @msg = params[:msg]
    @tlk = params[:tlk]

    mail(
      to: "#{@spkr.name} <#{@spkr.user.email}>",
      subject: "#{@tlk.title}: New message. Read it and reply."
    )
  end

  def new_msg_update_follower
    @follow = params[:follow]
    @msg = params[:msg]
    @tlk = params[:tlk]

    mail(
      to: "#{@follow.user.username} <#{@follow.user.email}>",
      subject: "#{@tlk.title}: New message for you to read."
    )
  end
end

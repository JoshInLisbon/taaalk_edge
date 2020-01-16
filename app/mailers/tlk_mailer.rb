class TlkMailer < ApplicationMailer
  def new_tlk_update_user_follower
    @tlk = params[:tlk]
    @followed_user = params[:followed_user]
    @follower = params[:follower]

    mail(
      to: "#{@follower.username} <#{@follower.email}>",
      subject: "#{@followed_user.username} has started a new Taaalk: #{@tlk.title}"
    )
  end
end

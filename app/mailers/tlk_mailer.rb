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

  def tlk_request
    @tlk_request = params[:tlk_request]
    @requested_user = params[:requested_user]
    @requesting_user = params[:requesting_user]

    mail(
      to: "#{@requested_user.username} <#{@requested_user.email}>",
      subject: "#{@requesting_user.username} would like to start a Taaalk with you 👀"
    )
  end
end

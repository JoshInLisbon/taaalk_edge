class TlkRequestMailer < ApplicationMailer
  def accepted
    @tlk = params[:tlk]
    @requesting_user = params[:requesting_user]
    @requested_user = params[:requested_user]

    mail(
      to: "#{@requesting_user.username} <#{@requesting_user.email}>",
      subject: "#{@requested_user.username} has accepted your Taaalk request | #{@tlk.title}"
    )
  end

  def rejected
    @tlk_request = params[:tlk_request]
    @requesting_user = params[:requesting_user]
    @requested_user = params[:requested_user]

    mail(
      to: "#{@requesting_user.username} <#{@requesting_user.email}>",
      subject: "#{@requested_user.username} has rejected your Taaalk request | #{@tlk_request.title}"
    )
  end
end

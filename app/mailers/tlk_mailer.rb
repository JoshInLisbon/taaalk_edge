class TlkMailer < ApplicationMailer
  def tlk_user_tlk_created
    @tlk = params[:tlk]
    @user = params[:user]

    mail(
      to: "#{@user.username} <#{@user.email}>",
      subject: "Detials for your Taaalk '#{@tlk.title}'"
    )
  end

  def tlk_spkr_tlk_joined
    @tlk = params[:tlk]
    @user = params[:user]

    mail(
      to: "#{@user.username} <#{@user.email}>",
      subject: "Details for your Taaalk '#{@tlk.title}'"
    )
  end

  def tlk_owner_tlk_joined
    @tlk = params[:tlk]
    @user = params[:user]
    @joined_user = params[:joined_user]

    mail(
      to: "#{@user.username} <#{@user.email}>",
      subject: "#{ @joined_user.username } joined your Taaalk '#{@tlk.title}'"
    )
  end

  def new_tlk_update_user_follower
    @tlk = params[:tlk]
    @followed_user = params[:followed_user]
    @follower = params[:follower]

    mail(
      to: "#{@follower.username} <#{@follower.email}>",
      subject: "#{@followed_user.username} has started a new Taaalk '#{@tlk.title}'"
    )
  end

  def tlk_request
    @tlk_request = params[:tlk_request]
    @requested_user = params[:requested_user]
    @requesting_user = params[:requesting_user]

    mail(
      to: "#{@requested_user.username} <#{@requested_user.email}>",
      subject: "#{@requesting_user.username} would like to Taaalk with you | #{@tlk_request.title}"
    )
  end
end

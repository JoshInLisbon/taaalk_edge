class MsgsController < ApplicationController
  def create
    msg = Msg.new(msg_params)
    msg.user = current_user
    msg.save!
    tlk = Tlk.friendly.find(params['msg']['tlk_id'])
    tlk.update(updated_at: Time.now)
    send_spkrs_new_msg_mail(tlk, msg)
    send_followers_new_msg_mail(tlk, msg)

    redirect_to show_tlk_path(tlk)
  end

  private

  def msg_params
    params.require(:msg).permit(:content, :tlk_id, :spkr_id)
  end

  def send_spkrs_new_msg_mail(tlk , msg)
    tlk.spkrs.each do |spkr|
      unless spkr == msg.spkr
        mail = MsgMailer.with(tlk: tlk, spkr: spkr, msg: msg).new_msg_update_spkr
        mail.deliver_later
      end
    end
  end

  def send_followers_new_msg_mail(tlk, msg)
    tlk.tlk_follows.each do |tlk_follow|
      mail = MsgMailer.with(tlk: tlk, follow: tlk_follow, msg: msg).new_msg_update_follower
      mail.deliver_later
    end
  end
end

class MsgsController < ApplicationController
  before_action :set_tlk
  before_action :set_spkr

  def create
    if verify
      if params[:publish]
        @msg = Msg.new(msg_params)
        @msg.user = current_user
        @msg.save!
        destroy_draft
        @tlk.update(updated_at: Time.now)
        send_spkrs_new_msg_mail
        send_followers_new_msg_mail
        redirect_to show_tlk_path(@tlk)
      elsif params[:draft]
        destroy_draft
        draft_msg = DraftMsg.new(msg_params)
        draft_msg.user = current_user
        draft_msg.save
        respond_to do |format|
          format.js { render 'create', layout: false }
        end
      end
    end
  end

  def update
  end

  private

  def set_spkr
    @spkr = Spkr.find(params[:msg][:spkr_id])
  end

  def set_tlk
    @tlk = Tlk.friendly.find(params['msg']['tlk_id'])
  end

  def destroy_draft
    draft_msg = DraftMsg.find_by(tlk: @tlk, spkr: @spkr, user: current_user)
    draft_msg.destroy if draft_msg.present?
  end

  def verify
    user_match && key_match
  end

  def user_match
    arr = []
    @tlk.spkrs.each do |spkr|
      arr << "true" if spkr.user == current_user
    end
    true if arr.any?
  end

  def key_match
    @tlk.msg_key == params.require(:msg).permit(:tlk_code)[:tlk_code]
  end

  def msg_params
    params.require(:msg).permit(:content, :tlk_id, :spkr_id, :safe_content)
  end

  def send_spkrs_new_msg_mail
    @tlk.spkrs.each do |spkr|
      unless spkr == @spkr
        mail = MsgMailer.with(tlk: @tlk, spkr: spkr, msg: @msg).new_msg_update_spkr
        mail.deliver_later
      end
    end
  end

  def send_followers_new_msg_mail
    @tlk.tlk_follows.each do |tlk_follow|
      mail = MsgMailer.with(tlk: @tlk, follow: tlk_follow, msg: @msg).new_msg_update_follower
      mail.deliver_later
    end
  end
end

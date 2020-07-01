class MsgsController < ApplicationController
  before_action :set_tlk, only: [:create, :update]
  before_action :set_spkr, only: [:create, :update]
  before_action :set_edit_msg, only: [:edit, :update, :destroy]

  def create
    if verify
      if params[:publish]
        if set_msg
          @msg.published = true
          @msg.created_at = Time.now
          @msg.update!(msg_params)
          @tlk.update(updated_at: Time.now)
          update_spkrs_to_reply
        else
          @msg = Msg.new(msg_params)
          @msg.user = current_user
          @msg.published = true
          @msg.save!
          @tlk.update(updated_at: Time.now)
          update_spkrs_to_reply
        end
        set_spkr_auto_tweet
        send_spkrs_new_msg_mail
        send_followers_new_msg_mail
        redirect_to show_tlk_path(@tlk)
      elsif params[:draft]
        if set_msg
          @new_draft = false
          @msg.update!(draft_msg_params)
          respond_to do |format|
            format.js { render 'draft', layout: false }
          end
        else
          @new_draft = true
          @msg = Msg.new(draft_msg_params)
          @msg.user = current_user
          @msg.save!
          respond_to do |format|
            format.js { render 'draft', layout: false }
          end
        end
      end
    end
  end

  def edit
    @edit = true
    unless @msg.user == current_user
      flash[:notice] = "You cannot edit a message you did not write."
      redirect_to root_path
    end
    @tlk = @msg.tlk
    @spkr = @msg.spkr
  end

  def update
    if verify
      @msg.update!(msg_params)
      flash[:notice] = "Your message has been updated."
      redirect_to show_tlk_path(@tlk)
    end
  end

  def destroy
    @msg.destroy
    flash[:notice] = "Your message has been deleted."
    redirect_to show_tlk_path(@msg.tlk)
  end

  private

  def update_spkrs_to_reply
    if @tlk.spkrs.length == 1
      @spkr.update_attribute(:to_reply, true) if @spkr.to_reply != true
    else
      @tlk.spkrs.each do |spkr|
        spkr != @spkr ? spkr.to_reply = true : spkr.to_reply = false
        spkr.save!
      end
    end
  end

  def set_spkr_auto_tweet
    if auto_tweet_params[:auto_tweet_on] != @spkr.auto_tweet_on
      @spkr.auto_tweet_on = auto_tweet_params[:auto_tweet_on]
      @spkr.save!
    end
  end

  def auto_tweet_params
    params.require(:msg).permit(:auto_tweet_on)
  end

  def set_edit_msg
    @msg = Msg.find(params[:id])
  end

  def set_msg
    params[:msg][:msg_id].present? ? @msg = Msg.find(params[:msg][:msg_id]) : false
  end

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

  def draft_msg_params
    params.require(:msg).permit(:tlk_id, :spkr_id, :draft_string)
  end

  def send_spkrs_new_msg_mail
    sent_spkr_users = []
    @tlk.non_hidden_spkrs.each do |spkr|
      unless spkr.user == @spkr.user
        unless sent_spkr_users.include?(spkr.user)
          mail = MsgMailer.with(tlk: @tlk, spkr: spkr, msg: @msg).new_msg_update_spkr
          mail.deliver_later
        end
        sent_spkr_users << spkr.user
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

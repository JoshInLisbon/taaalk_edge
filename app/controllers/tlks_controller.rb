class TlksController < ApplicationController
  require 'digest/md5'
  include SpkrMaker

  skip_before_action :authenticate_user!, only: [:index, :show, :new]

  def index
    @tlks = Tlk.includes(:msgs).where.not(msgs: { id: nil }).paginate(page: params[:page], per_page: 30).order(updated_at: :desc)
    @title = "The home of public conversations"
  end

  def replies
    set_replies_and_no_replies
    @title = 'Your Replies'
  end

  def show
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
    @msgs = @tlk.msgs.sort_by(&:created_at)
    @title = "#{@tlk.title} - #{spkr_names}"
    @user_spkrs = Spkr.where(tlk: @tlk, user: current_user, hide: false).sort_by(&:created_at)
    @msg = Msg.new()
    new_spkr_on_invite
    user_is_spkr_only? if current_user.present?
    @tweet = tweet if user_is_spkr_only? || @tlk.user == current_user
    updated_at = @tlk.updated_at
    view_count = @tlk.views += 1
    @tlk.update_columns(views: view_count, updated_at: updated_at)
  end

  def new
    @tlk = Tlk.new()
    @title = "Start a conversation"
    @tlk_with_me_users = User.joins(:rich_text_tlk_with_me).paginate(page: params[:page], per_page: 30).order(updated_at: :desc)
    if current_user.present?
      @twm_present = current_user.tlk_with_me.present? ? true : false
    end
  end

  def edit
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
  end

  def create
    # If making changes, this method also exists in TlkRequestsController
    @tlk = Tlk.new(tlk_params)
    @tlk.user = current_user
    @tlk.invite_code = '%010d' % rand(100000000..999999999)
    @tlk.msg_key = Digest::MD5.hexdigest(@tlk.title)
    if @tlk.save!
      make_spkr
      @spkr.update_attribute(:to_reply, true)
      send_tlk_user_tlk_created_mail
      send_user_followers_new_tlk_mail
      redirect_to show_tlk_path(@tlk), flash: { edit: true }
    end
  end

  def update
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
    @tlk.update(tlk_params)
    respond_to do |format|
      format.js { render 'update', layout: false } # { @tlk }# <-- will render `app/views/reviews/create.js.erb`
      format.html { redirect_to new_tlk_path(@tlk) }
    end
  end

  def destroy
    @tlk = Tlk.friendly.find(params[:id])
    if current_user.valid_password?(password_param[:password]) && @tlk.user == current_user
      @tlk.destroy
      redirect_to root_path
      flash[:notice] = "Your Taaalk has been deleted."
    else
      redirect_to show_tlk_path(@tlk)
      flash[:notice] = "Password not correct."
    end
  end

  private

  def set_replies_and_no_replies
    @has_no_messages_replies = []
    @normal_replies = []
    @only_spkr_replies = []
    @multiple_same_spkr_replies = []
    @no_replies = []

    current_user.spkrs.each do |spkr|
      if spkr.tlk.msgs.any?
        if spkr.tlk.spkrs.length == 1
          @only_spkr_replies << spkr.tlk


        elsif spkr.to_reply == true
          spkr.tlk.spkrs.each do |tlk_spkr|
            if tlk_spkr != spkr
              if tlk_spkr.user == spkr.user
                if @multiple_same_spkr_replies.exclude?(spkr.tlk)
                  @multiple_same_spkr_replies << spkr.tlk
                end
              else
                @normal_replies << spkr.tlk
              end
            end
          end
        else
          @no_replies << spkr.tlk
        end
      elsif spkr.tlk.user == spkr.user
        @has_no_messages_replies << spkr.tlk
      else
        @no_replies << spkr.tlk
      end
    end

    @has_no_messages_replies.sort! { |a, b| b.updated_at <=> a.updated_at }
    @normal_replies.sort! { |a, b| b.updated_at <=> a.updated_at }
    @only_spkr_replies.sort! { |a, b| b.updated_at <=> a.updated_at }
    @multiple_same_spkr_replies.sort! { |a, b| b.updated_at <=> a.updated_at }
    @no_replies.sort! { |a, b| b.updated_at <=> a.updated_at }
  end

  def spkr_names
    spkr_name_list = ""
    @tlk.spkrs.each_with_index do |spkr, i|
      if @tlk.spkrs.length == 1
        spkr_name_list << spkr.name
      elsif i + 2 == @tlk.spkrs.length
        spkr_name_list << "#{spkr.name} "
      elsif i + 1 == @tlk.spkrs.length
        spkr_name_list << "& #{spkr.name}"
      else
        spkr_name_list << "#{spkr.name}, "
      end
    end
    spkr_name_list
  end

  def password_param
    params.require(:tlk).permit(:password)
  end

  def tlk_params
    params.require(:tlk).permit(:title, :image)
  end

  def new_spkr_on_invite
    @spkr = Spkr.new() if flash[:invited]
  end

  def user_is_spkr_only?
    @tlk.spkrs.each do |spkr|
      @spkr_only = true if spkr.user == current_user && @tlk.user != current_user
    end
  end

  def send_tlk_user_tlk_created_mail
    mail = TlkMailer.with(
      tlk: @tlk,
      user: current_user
    ).tlk_user_tlk_created
    mail.deliver_later
  end

  def send_user_followers_new_tlk_mail
    current_user.followers.each do |follower|
      mail = TlkMailer.with(
        tlk: @tlk,
        followed_user: current_user,
        follower: follower
      ).new_tlk_update_user_follower
      mail.deliver_later
    end
  end

  def non_hidden_non_current_user_spkrs
    @tlk.spkrs.where.not(user: current_user).where(hide: false).sort_by(&:created_at)
  end

  def tweet
    tweet = "I wrote a new message in my Taaalk \"#{@tlk.title}\""
    spkrs_tweet_section = ""
    if non_hidden_non_current_user_spkrs.present?
      spkrs_tweet_section << " with "
      non_hidden_non_current_user_spkrs.each_with_index do |spkr, i| # needs to be other spkrs vs current user, so cannot be in model
        spkr_name_and_twitter = spkr.twitter_handle.present? ? "#{spkr.name} (@#{spkr.twitter_handle})" : spkr.name
        if non_hidden_non_current_user_spkrs.length == 1
          spkrs_tweet_section << "#{spkr_name_and_twitter}"
        elsif i + 2 == non_hidden_non_current_user_spkrs.length
          spkrs_tweet_section << "#{spkr_name_and_twitter} "
        elsif i + 1 == non_hidden_non_current_user_spkrs.length
          spkrs_tweet_section << "& #{spkr_name_and_twitter}"
        else
          spkrs_tweet_section << "#{spkr_name_and_twitter}, "
        end
      end
    end
    if (tweet + spkrs_tweet_section).length <= 116
      tweet << spkrs_tweet_section + " #{show_tlk_url}"
    elsif tweet.length <= 116
      tweet << " #{show_tlk_url}"
    else
      tweet = "I wrote a new message in my Taaalk #{show_tlk_url}"
    end
  end
end

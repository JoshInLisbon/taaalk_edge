class SpkrsController < ApplicationController
  before_action :set_spkr
  skip_before_action :authenticate_user!, only: :edit_suggested

  def update
    if @spkr.user == current_user
      params = spkr_params.merge!(spkr_color_param)
      @spkr.update(params)
      complete_user_profile
      respond_to do |format|
        format.js # { @tlk }# <-- will render `app/views/reviews/create.js.erb`
        # format.html { redirect_to new_tlk_path(@tlk) }
      end
    else
      spkr_edited
      send_spkr_edited_mail
    end
  end

  def destroy
    @spkr.destroy
    redirect_to show_tlk_path(@spkr.tlk)
  end

  def hide_spkr
    @spkr.hide = true
    @spkr.save!
    redirect_to show_tlk_path(@spkr.tlk)
  end

  def edit_confirmed
    if @spkr.user == current_user
      if @spkr.edited_name.present?
        @spkr.name = @spkr.edited_name
      end
      if @spkr.edited_biog.present?
        @spkr.biog = @spkr.edited_biog
      end
      if @spkr.edited_image.present?
        @spkr.image.purge
        @spkr.image = @spkr.edited_image.blob
      end
      if @spkr.edited_color.present?
        @spkr.color = @spkr.edited_color
      end
      @spkr.save!
      complete_user_profile_on_edit
      redirect_to show_tlk_path(@spkr.tlk)
    else
      flash[:notice] = "You must be the logged in as the account holder for #{@spkr.name} to confirm an edit. Right now you are not logged in as this user."
      redirect_to edit_suggested_path(@spkr.tlk, @spkr)
    end
  end

  def edit_suggested
    @title = "Suggested edit to #{@spkr.name}"
  end

  def edit_rejected
    redirect_to show_tlk_path(@spkr.tlk)
  end

  private

  def set_spkr
    @spkr = Spkr.find(params[:id])
  end

  def spkr_params
    params.require(:spkr).permit(:name, :bio, :image, :biog)
  end

  def spkr_color_param
    params.permit(:color)
  end

  def complete_user_profile_on_edit
    if @spkr.name.present?
      current_user.update_attributes(username: @spkr.name) unless current_user.username.present?
    end
    if @spkr.bio.present?
      current_user.update_attributes(bio: @spkr.bio) unless current_user.bio.present?
    end
    if @spkr.image.present?
      current_user.update_attributes(image: @spkr.image.blob) unless current_user.image.present?
    end
    if @spkr.biog.present?
      current_user.update_attributes(biog: @spkr.biog) unless current_user.biog.present?
    end
  end

  def complete_user_profile
    if spkr_params[:name].present?
      current_user.update_attributes(username: spkr_params[:name]) unless current_user.username.present?
    end
    if spkr_params[:bio].present?
      current_user.update_attributes(bio: spkr_params[:bio]) unless current_user.bio.present?
    end
    if spkr_params[:image].present?
      current_user.update_attributes(image: spkr_params[:image]) unless current_user.image.present?
    end
    if spkr_params[:biog].present?
      current_user.update_attributes(biog: spkr_params[:biog]) unless current_user.biog.present?
    end
  end

  def spkr_edited
    if spkr_params[:name] != @spkr.name
      @spkr.edited_name = spkr_params[:name]
    end
    if spkr_params[:bio] != @spkr.bio
      @spkr.edited_bio = spkr_params[:bio]
    end
    if spkr_params[:biog] != @spkr.biog
      @spkr.edited_biog = spkr_params[:biog]
    end
    if params.permit(:color)[:color] != @spkr.color
      @spkr.edited_color = /(msg-)(.*)/.match(params.permit(:color)[:color])[2]
    end
    if spkr_params[:image].present?
      @spkr.edited_image = spkr_params[:image]
    end
    @spkr.save!
  end

  def send_spkr_edited_mail
    editing_spkr = ""

    @spkr.tlk.spkrs.each do |spkr|
      if spkr.user == current_user
        editing_spkr = spkr
      end
    end

    mail = SpkrMailer.with(spkr: @spkr, editing_spkr: editing_spkr, tlk: @spkr.tlk).edited_spkr
    mail.deliver_later
  end

  def send_spkr_edit_accept_mail
    mail = SpkrMailer.with(spkr: @spkr, editing_spkr: @spkr.tlk.spkr, tlk: @spkr.tlk).accept_edit
    mail.deliver_later
  end

  def send_spkr_edit_reject_mail
    mail = SpkrMailer.with(spkr: @spkr, editing_spkr: @spkr.tlk.spkr, tlk: @spkr.tlk).reject_edit
    mail.deliver_later
  end
end

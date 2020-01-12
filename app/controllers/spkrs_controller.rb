class SpkrsController < ApplicationController
  before_action :set_spkr

  def update
    if @spkr.user == current_user
      @spkr.update(spkr_params)
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
    if @spkr.edited_name.present?
      @spkr.name = @spkr.edited_name
      @spkr.save!
    end
    if @spkr.edited_bio.present?
      @spkr.bio = @spkr.edited_bio
      @spkr.save!
    end
    complete_user_profile
    redirect_to show_tlk_path(@spkr.tlk)
  end

  private

  def set_spkr
    @spkr = Spkr.find(params[:id])
  end

  def spkr_params
    params.require(:spkr).permit(:name, :bio, :image)
  end

  def complete_user_profile
    current_user.update_attributes(username: spkr_params[:name]) unless current_user.username.present?
    current_user.update_attributes(bio: spkr_params[:bio]) unless current_user.bio.present?
    current_user.update_attributes(image: spkr_params[:image]) unless current_user.image.present?
  end

  def spkr_edited
    if spkr_params[:name] != @spkr.name
      @spkr.edited_name = spkr_params[:name]
      @spkr.save!
    end
    if spkr_params[:bio] != @spkr.bio
      @spkr.edited_bio = spkr_params[:bio]
      @spkr.save!
    end
  end

  def send_spkr_edited_mail
    mail = SpkrMailer.with(spkr: @spkr, editing_user: current_user, tlk: @spkr.tlk).edited_spkr
    mail.deliver_later
  end
end

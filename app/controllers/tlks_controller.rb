class TlksController < ApplicationController
  include SpkrMaker

  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @tlks = Tlk.includes(:spkrs).paginate(page: params[:page], per_page: 30).order(updated_at: :desc)
  end

  def newly_created
    @tlks = Tlk.includes(:spkrs).paginate(page: params[:page], per_page: 30).order(created_at: :desc)
  end

  def show
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
    @user_spkrs = Spkr.where(tlk: @tlk, user: current_user)
    @msg = Msg.new()
    new_spkr_on_invite
    user_is_spkr_only? if current_user.present?
  end

  def new
    @tlk = Tlk.new()
  end

  def edit
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
  end

  def create
    @tlk = Tlk.new(tlk_params)
    @tlk.user = current_user
    @tlk.invite_code = '%010d' % rand(0..999999)
    if @tlk.save!
      @edit = true
      make_spkr
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

  private

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

# do I need this??

  # def create_external_spkrs
  #   external_params = params.require(:tlk).permit(:p_email, :p_name, :p_bio)
  #   if User.find_by_email(external_params[:p_email])
  #     puts "nothing"
  #   else
  #     @new_spkr = NewSpkr.create!(
  #       email: external_params[:p_email],
  #       name: external_params[:p_name],
  #       bio: external_params[:P_bio]
  #     )
  #     NewSpkrMailer.with(tlk: @tlk, new_spkr: @new_spkr).welcome.deliver_later
  #   end
  # end

end

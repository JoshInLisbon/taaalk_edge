class TlksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @tlks = Tlk.includes(:spkrs)
  end

  def show
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
    @user_spkrs = Spkr.where(tlk: @tlk, user: current_user)
    @msg = Msg.new()
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
    if @tlk.save!
      respond_to do |format|
        format.js # { @tlk }# <-- will render `app/views/reviews/create.js.erb`
        format.html { redirect_to new_tlk_path(@tlk) }
      end
    end
    # create_self_spkr
    # create_external_spkrs
    # redirect_to show_tlk_path(@tlk)
  end

  def update
    @tlk = Tlk.includes(:spkrs, :msgs).friendly.find(params[:id])
    @tlk.update(tlk_params)
    create_self_spkr
    redirect_to show_tlk_path(@tlk)
  end

  private

  def tlk_params
    params.require(:tlk).permit(:title)
  end

  def create_self_spkr
    self_params = params.require(:tlk).permit(:name, :bio)
    spkr = Spkr.new(self_params)
    spkr.user = current_user
    spkr.tlk = @tlk
    spkr.save!
  end

  def create_external_spkrs
    external_params = params.require(:tlk).permit(:p_email, :p_name, :p_bio)
    if User.find_by_email(external_params[:p_email])
      # spkrMailer.with(tlk: @tlk).unregistered_spkr.deliver_later
      puts "nothing"
    else
      @new_spkr = NewSpkr.create!(
        email: external_params[:p_email],
        name: external_params[:p_name],
        bio: external_params[:P_bio]
      )
      NewSpkrMailer.with(tlk: @tlk, new_spkr: @new_spkr).welcome.deliver_later
    end
  end

end

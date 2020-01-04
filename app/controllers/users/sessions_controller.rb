# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include SpkrMaker
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if params.include? :spkr
      super
      invited_params
      if @invite_code.to_i == @tlk.invite_code
        make_spkr
      end
    else
      super
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def invited_params
    @invite_code = params.require(:spkr).permit(:flash_invite_code)[:flash_invite_code]
    tlk_id = params.require(:spkr).permit(:tlk_id)[:tlk_id]
    @tlk = Tlk.find(tlk_id)
  end
end

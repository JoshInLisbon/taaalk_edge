class MsgsController < ApplicationController
  def create
    msg = Msg.new(msg_params)
    msg.user = current_user
    msg.save!
    tlk = Tlk.friendly.find(params['msg']['tlk_id'])
    redirect_to show_tlk_path(tlk)
  end

  private

  def msg_params
    params.require(:msg).permit(:content, :tlk_id, :spkr_id)
  end
end

class SuportsController < ApplicationController
  before_action :set_suport, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_owner_or_admin!

  # GET /suports
  # GET /suports.json
  def index
    @suport = Suport.new
    render :action => 'index'
  end

  def confirm
    # 入力値のチェック
    @suport = Suport.new(params[:suport].permit(:name, :email, :message))
    if @suport.valid?
      # OK。確認画面を表示
      render :action => 'confirm'
    else
      # NG。入力画面を再表示
      render :action => 'index'
    end
  end

  def thanks
    # メール送信
    @suport = Suport.new(params[:suport].permit(:name, :email, :message))
    SuportMailer.suport_email(@suport).deliver
    SuportMailer.get_suport_email(@suport).deliver

    # 完了画面を表示
    render :action => 'thanks'
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suport
      @suport = Suport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def suport_params
      params.require(:suport).permit(:name, :email, :subject, :message, :user_id, :owner_id)
    end
end

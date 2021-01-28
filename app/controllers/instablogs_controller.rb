class InstablogsController < ApplicationController

  def index
  end

  def show
    @subscription = Subscription.find(params[:id])
    @instablogs = @subscription.instablogs.where(params[:subscription_id]).order(created_at: :desc)
  end

  def new
    @instablog = Instablog.new
    @subscription = Subscription.find(params[:subscription_id])
  end

  def create
    @instablog = Instablog.new(instablog_params)
      if @instablog.save
        flash[:success] = "instagram投稿を作成できました"
        redirect_to root_path
      else
        flash[:danger] = "作成に失敗しました"
        render :new
      end
  end

  def destroy
    Instablog.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_back(fallback_location: instablog_path)
  end

  private
    def instablog_params
      params.require(:instablog).permit(:insta_content, :subscription_id)
    end
end

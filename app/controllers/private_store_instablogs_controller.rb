class PrivateStoreInstablogsController < ApplicationController

  def index
  end

  def show
    @private_store = PrivateStore.find(params[:id])
    @private_store_instablogs = @private_store.private_store_instablogs.where(params[:private_store_id]).order(created_at: :desc)
  end

  def new
    @private_store_instablog = PrivateStoreInstablog.new
    @private_store = PrivateStore.find(params[:private_store_id])
  end

  def create
    @private_store_instablog = PrivateStoreInstablog.new(private_store_instablog_params)
    if @private_store_instablog.save
        flash[:success] = "instagram投稿を作成できました"
        redirect_to root_path
      else
        flash[:danger] = "作成に失敗しました"
        render :new
      end
  end

  def destroy
    PrivateStoreInstablog.find(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_back(fallback_location: private_store_instablog_path)
  end

  private
    def private_store_instablog_params
      params.require(:private_store_instablog).permit(:insta_content, :private_store_id)
    end
end

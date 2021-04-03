class PrivateStoreInstablogsController < ApplicationController

  def index
  end

  def show
    @private_store = PrivateStore.find(params[:id])
    @private_store_instablogs_count = @private_store.private_store_instablogs.count
    @private_store_instablogs = @private_store.private_store_instablogs.where(params[:private_store_id]).order(created_at: :desc)
  end

  def new
    @private_store_instablog = PrivateStoreInstablog.new
    @private_store = PrivateStore.find(params[:private_store_id])
    @private_store_instablogs = @private_store.private_store_instablogs.where(params[:private_store_id]).order(created_at: :desc)
  end

  def create
    @private_store_instablog = PrivateStoreInstablog.new(private_store_instablog_params)
    if @private_store_instablog.save
        flash[:success] = "instagramを投稿しました"
        redirect_to owner_private_stores_url(owner_id: current_owner.id)
      else
        flash[:danger] = "投稿に失敗しました"
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

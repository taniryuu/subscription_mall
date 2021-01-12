class MegurumereviewsController < ApplicationController

  def index
    @megurumereviews = Megurumereview.all
  end

  def new
    @megurumereview = Megurumereview.new
  end

  def create
    @megurumereview = Megurumereview.new(megurumereview_params)
      if @megurumereview.save!
        redirect_to user_account_user_path(current_user)
      else
        redirect_to root_path
      end
  end

  def destroy
    Megurumereview.find_by(params[:id]).destroy
    flash[:success] = "削除しました。"
    redirect_to megurumereviews_url
  end

  private

    def megurumereview_params
      params.require(:megurumereview).permit(:email, :content, :score, :user_id)
    end
end

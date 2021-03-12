class MegurumereviewsController < ApplicationController
  # before_action :login_current_owner, only: %i()

  def index
    @megurumereviews = Megurumereview.paginate(page: params[:page], per_page: 10)
  end

  def new
    @megurumereview = Megurumereview.new
  end

  def create
    @megurumereview = Megurumereview.new(megurumereview_params)
      if @megurumereview.save!
        redirect_to megurumereviews_url(current_user)
      else
        render :new
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

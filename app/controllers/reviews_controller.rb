class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy, :edit_subscription_reviews]
  before_action :set_user, only: [:index, :new, :create, :show, :edit, :update, :destroy, :edit_subscription_reviews]
  before_action :reviews_lock, only: %i(new edit subscription_reviews edit_subscription_reviews)

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.includes(:user).limit(5)
  end

  def list
    @reviews = Review.includes(:user)
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    respond_to do |format|
      if @review.save
        format.html { redirect_to categories_url, notice: 'レビューを投稿しました！' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        render :new
      end
    end
  end

  # GET /reviews/1/edit
  def edit
    @subscription = Subscription.find(params[:subscription_id])
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to categories_url, notice: 'レビューの更新完了です！' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'レビューの削除完了です！' }
      format.json { head :no_content }
    end
  end

  def subscription_reviews
    @subscription = Subscription.find(params[:subscription_id])
  end

  def private_store_reviews
    @private_store = PrivateStore.find(params[:private_store_id])
  end

  def edit_subscription_reviews
    @subscription = Subscription.find(params[:subscription_id])
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:name, :email, :content, :score, :subscription_id, :user_id)
    end

    def reviews_lock
      if current_owner.present?
        redirect_to root_url, notice: '権限がありません！'
      end
    end
end

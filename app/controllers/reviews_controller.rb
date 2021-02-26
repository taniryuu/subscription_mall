class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index, :new, :show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.includes(:user)
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
      if @review.save!
        redirect_to user_account_user_path(current_user)
      else
        redirect_to root_path
      end
  end

  # GET /reviews/1/edit
  def edit
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to user_reviews_url, notice: 'レビューの更新完了です！' }
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
      format.html { redirect_to user_reviews_url, notice: 'レビューの削除完了です！' }
      format.json { head :no_content }
    end
  end

  def subscription_reviews
    @subscription = Subscription.find_by(params[:subscription_id])
  end

  def private_store_reviews
    @private_store = PrivateStore.find_by(params[:private_store_id])
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
      params.require(:review).permit(:email, :content, :score, :subscription_id, :user_id)
    end
end

class CategoriesController < ApplicationController
  before_action :set_category, only: [:like_lunch]
  # before_action :set_subscription, only: [:show]

  def index
    @categories = if params[:search]
      Category.search(params[:search]).order("RAND()")
    else
      Category.order("RAND()").all
    end
    @categories_name = Category.where.not(name: nil)#検索機能が選択ボックスだったら使う
  end

  def like_lunch
    @categories = Category.find(params[:id])
    @subscription = Subscription.find_by(params[:id])
    @owner = Owner.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @categories = Category.where.not(name: nil)
  end


  def shop_list
    @subscriptions = Subscription.all
  end

  def recommend
    @subscriptions = Subscription.where(recommend: true).order(created_at: :asc).limit(15)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end
    

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :image_category, :user_id, :owner_id)
    end
end

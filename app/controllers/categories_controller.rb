class CategoriesController < ApplicationController
  before_action :set_category, only: [:like_lunch, :edit, :update, :destroy]

  def index
    @categories = Category.where.not(name: nil)
    @categories_name = Category.where.not(name: nil)
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

  def like_lunch
  end

  def shop_list
    @subscriptions = Subscription.all
    @private_stores = PrivateStore.all
  end

  def recommend
    @subscriptions = Subscription.where(recommend: true).order(created_at: :desc).limit(15)
    @private_stores = PrivateStore.where(recommend: true).order(created_at: :desc).limit(15)

  end

  def washoku
    @subscriptions = Subscription.order("RAND()").where(category_name: 1)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 1)
  end

  def teishoku
    @subscriptions = Subscription.order("RAND()").where(category_genre: 9)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 9)
  end

  def ramen
    @subscriptions = Subscription.order("RAND()").where(category_genre: 2)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 2)
  end

  def cafe
    @subscriptions = Subscription.order("RAND()").where(category_genre: 1)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 1)
  end

  def pan
    @subscriptions = Subscription.order("RAND()").where(category_genre: 3)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 3)
  end

  def izakaya
    @subscriptions = Subscription.order("RAND()").where(category_genre: 5)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 5)
  end

  def itarian
    @subscriptions = Subscription.order("RAND()").where(category_name: 4)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 4)
  end

  def chuuka
    @subscriptions = Subscription.order("RAND()").where(category_name: 3)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 3)
  end

  def french
    @subscriptions = Subscription.order("RAND()").where(category_name: 5)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 5)
  end

  def hawaian
    @subscriptions = Subscription.order("RAND()").where(category_name: 6)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 6)
  end

  def tonanajia
    @subscriptions = Subscription.order("RAND()").where(category_name: 7)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 7)
  end

  def bar
    @subscriptions = Subscription.order("RAND()").where(category_genre: 6)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 6)
  end

  def cake
    @subscriptions = Subscription.order("RAND()").where(category_genre: 7)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 7)
  end

  def yakiniku
    @subscriptions = Subscription.order("RAND()").where(category_genre: 8)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 8)
  end

  def yoshoku
    @subscriptions = Subscription.order("RAND()").where(category_name: 2)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 2)
  end

  def curry
    @subscriptions = Subscription.order("RAND()").where(category_genre: 4)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 4)
  end

  def humburger
    @subscriptions = Subscription.order("RAND()").where(category_genre: 10)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 10)
  end

  def kankokuryori
    @subscriptions = Subscription.order("RAND()").where(category_name: 10)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 10)
  end

  def restaurant
    @subscriptions = Subscription.order("RAND()").where(category_genre: 11)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 11)
  end

  def okonomiyaki
    @subscriptions = Subscription.order("RAND()").where(category_genre: 12)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 12)
  end

  def nabe
    @subscriptions = Subscription.order("RAND()").where(category_name: 8)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 8)
  end

  def sweets
    @subscriptions = Subscription.order("RAND()").where(category_name: 11)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 11)
  end

  def karaage
    @subscriptions = Subscription.order("RAND()").where(category_genre: 13)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 13)
  end

  def gyouza
    @subscriptions = Subscription.order("RAND()").where(category_genre: 14)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 14)
  end

  def don
    @subscriptions = Subscription.order("RAND()").where(category_name: 9)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 9)
  end

  def udon
    @subscriptions = Subscription.order("RAND()").where(category_genre: 15)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 15)
  end

  def soba
    @subscriptions = Subscription.order("RAND()").where(category_genre: 16)
    @private_stores = PrivateStore.order("RAND()").where(category_genre: 16)
  end

  def other
    @subscriptions = Subscription.order("RAND()").where(category_name: 12)
    @private_stores = PrivateStore.order("RAND()").where(category_name: 12)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :image_category, :user_id, :owner_id)
    end
end

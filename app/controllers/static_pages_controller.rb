class StaticPagesController < ApplicationController
  before_action :map_object, only: :top

  def top
    @blogs = Blog.all
    @reviews = Review.all
    @questions = Question.all
    @interviews = Interview.where.not(shop_name: nil)
    @megurumereviews = Megurumereview.all
    @owners = Owner.all
    @categories_name = Category.where.not(name: nil)#検索機能が選択ボックスだったら使う
    @categories = if params[:search]
      Category.search(params[:search]).order("RAND()").limit(6)
    else
      Category.order("RAND()").limit(6)
    end
  end

  def top_owner
    @blogs = Blog.all
    @interviews = Interview.where.not(shop_name: nil)
    @questions = Question.all
    @categories_name = Category.where.not(name: nil)#検索機能が選択ボックスだったら使う
    @categories = if params[:search]
      Category.search(params[:search]).order("RAND()").limit(6)
    else
      Category.order("RAND()").limit(6)
    end
  end

  def how_to_use
  end

  def discussion
  end

  def specified_commercial_transaction_law
  end

<<<<<<< HEAD
  def paypaytest
=======
  def map_object
    if params[:map].present? && params[:map][:address].present?
      results = Geocoder.search(params[:map][:address])
      @latlng = results.first.geometry
      top = @latlng["location"]["lng"] + 0.2
      bottom = @latlng["location"]["lng"] - 0.2
      left = @latlng["location"]["lat"] + 0.2
      right = @latlng["location"]["lat"] - 0.2
      gon.subscriptions = Subscription.where(longitude: bottom..top).where(latitude: right..left)
    else
      gon.subscriptions = Subscription.where(longitude: 139.5..139.9).where(latitude: 35.4..35.8)
    end
>>>>>>> 2005d45a717f89a4aac616c9419ea1dd73787754
  end

  private

end

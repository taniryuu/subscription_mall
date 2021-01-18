class StaticPagesController < ApplicationController

  def top
    @blogs = Blog.all
    @reviews = Review.all
    @questions = Question.all
    @megurumereviews = Megurumereview.all
    results = Geocoder.search(params[:address])
    @latlng = results.first
    @owners = Owner.all
    gon.subscriptions = Subscription.all
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
    results = Geocoder.search(params[:address])
    @latlng = results.first
    @map = Map.find(1)
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

  private
  
    def map_params
      params.require(:map).permit(:address, :latitude, :longitude, :distance, :near_distance, :time, :near_time, :title, :comment)
    end

end

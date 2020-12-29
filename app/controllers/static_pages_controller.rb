class StaticPagesController < ApplicationController

  def top
    @blogs = Blog.all
    @interviews = Interview.where.not(shop_name: nil)
    @questions = Question.all
    results = Geocoder.search(params[:address])
    @latlng = results.first
    @map = Map.find(1)
    @owners = Owner.all
    gon.owners = Owner.where.not(store_information: nil)
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
    @map = Map.find(params[:id])
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
    # Use callbacks to share common setup or constraints between actions.
    def set_map
      @map = Map.find(1)
    end

    # Only allow a list of trusted parameters through.
    def map_params
      params.require(:map).permit(:address, :latitude, :longitude, :distance, :near_distance, :time, :near_time, :title, :comment)
    end

end

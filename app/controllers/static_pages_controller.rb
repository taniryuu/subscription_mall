class StaticPagesController < ApplicationController
  before_action :map_object, :recommend_in_range, only: :top

  def top
    @blogs = Blog.all
    @reviews = Review.all
    @questions = Question.all
    @medias = Medium.all.limit(5)
    @interviews = Interview.where.not(shop_name: nil)
    @subscription = Subscription.find_by(params[:id])
    @owner_subscriptions = Subscription.includes(:owner).where(recommend: true).order(created_at: :asc).limit(5)
    @subscriptions = Subscription.where(recommend: true).order(created_at: :asc).limit(5)
    @megurumereviews = Megurumereview.all
    @owners = Owner.all.limit(5)
    # @category = Category.find_by(params[:id])
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

  def megurume_line
    
  end

  def how_to_use
  end

  def discussion
  end

  def specified_commercial_transaction_law
  end

  def map_object
    if params[:address].present?
      @latlng = Geocoder.search(params[:address]).first.geometry
      top = @latlng["location"]["lng"] + 0.2
      bottom = @latlng["location"]["lng"] - 0.2
      left = @latlng["location"]["lat"] + 0.2
      right = @latlng["location"]["lat"] - 0.2
      gon.subscriptions = Subscription.where(longitude: bottom..top).where(latitude: right..left)
    else
      gon.subscriptions = Subscription.all#where(longitude: 139.5..139.9).where(latitude: 35.4..35.8)
    end
  end

  
  private
  
    # 近所かつ最新のチケットログのカテゴリーの飲食店を3店格納
    def recommend_in_range
      if current_user.present? && current_user.address.present?
        # 自分の住所の範囲内の飲食店取得
        latlng = Geocoder.search(current_user.address).first.geometry
        top = latlng["location"]["lng"] + 0.2
        bottom = latlng["location"]["lng"] - 0.2
        left = latlng["location"]["lat"] + 0.2
        right = latlng["location"]["lat"] - 0.2 
        subscriptions_in_range = Subscription.where(longitude: bottom..top).where(latitude: right..left)
        # 最新のチケットログのジャンルから使用した飲食店取得
        if current_user.ticket_logs.present?
          @recommend_in_range = subscriptions_in_range.where(category_id: current_user.ticket_logs.last.category_id).sample(5)
        else
          @recommend_in_range = subscriptions_in_range.sample(5)
        end
      end
    end
end

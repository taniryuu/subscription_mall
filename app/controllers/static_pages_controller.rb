class StaticPagesController < ApplicationController

  def top
    @blogs = Blog.all
    @interviews = Interview.where.not(shop_name: nil)
    @questions = Question.all
    # @categories_name = Category.where.not(name: nil)#検索機能が選択ボックスだったら使う
    @categories = if params[:search]
      Category.search(params[:search]).order("RANDOM()").limit(6)
    else 
      Category.order("RANDOM()").limit(6)
    end
  end

  def discussion
  end
  
end

class StaticPagesController < ApplicationController

  def top
    @blogs = Blog.all
    @categories = Category.all
    @interviews = Interview.where.not(shop_name: nil)
  end

  def discussion
  end
end

class StaticPagesController < ApplicationController

  def top
    @blogs = Blog.all
    @categories = Category.all
    @interviews = Interview.where.not(shop_name: nil)
    @questions = Question.all
  end

  def discussion
  end
  
end

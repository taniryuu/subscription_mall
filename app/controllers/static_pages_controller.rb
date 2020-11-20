class StaticPagesController < ApplicationController

  def top
    @blogs = Blog.all
    @categories = Category.all
  end

  def discussion
  end
end

class StaticPagesController < ApplicationController

  def top
    @blogs = Blog.all
    @interviews = Interview.where.not(shop_name: nil)
    @questions = Question.all

    @subscription_data = Stripe::Checkout::Session.retrieve(
      'cs_test_a1ybqOPB9Mb27l9HqnC9EQWJiB9vb4NBzxOGTwqEcODmmu1rYtL1yNddkC',
    )
    @categories_name = Category.where.not(name: nil)#検索機能が選択ボックスだったら使う
    @categories = if params[:search]
      Category.search(params[:search]).order("RANDOM()").limit(6)
    else
      Category.order("RANDOM()").limit(6)
    end
  end

  def discussion
  end

end

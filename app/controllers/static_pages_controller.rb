class StaticPagesController < ApplicationController

  def top
    @blogs = Blog.all
    @categories = Category.all
    @interviews = Interview.where.not(shop_name: nil)
    @questions = Question.all

    @subscription_data = Stripe::Checkout::Session.retrieve(
      'cs_test_a1ybqOPB9Mb27l9HqnC9EQWJiB9vb4NBzxOGTwqEcODmmu1rYtL1yNddkC',
    )
  end

  def discussion
  end

end

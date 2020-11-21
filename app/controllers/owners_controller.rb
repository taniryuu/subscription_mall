class OwnersController < ApplicationController
  
  def index
    @owners = Owner.all
  end

  def interviews_index
    # owner = Owner.find(params[:id])
    # @interviews = owner.interviews
  end

  def show
      @owner = Owner.find(params[:id])
    if @subscriptions == 0 
      @subscription = Subscription.find(params[:id])
    else
      # @shop = Shop.find(params[:shop_id])
      @subscriptions = Subscription.where.not(name: nil).size
    end
  end

  def owner_account
    @owner = Owner.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

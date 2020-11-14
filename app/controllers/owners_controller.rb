class OwnersController < ApplicationController
  def index
  end

  def show
    @owner = Owner.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

class MediasController < ApplicationController
  before_action :set_media, only: [:edit, :update, :destroy]

  def index
    @medias = Medium.all
  end

  def new
    @media = Medium.new
  end

  def create
    @media = Medium.new(media_params)
    respond_to do |format|
      if @media.save
        format.html { redirect_to medias_url(@media), notice: 'メディアを作成しました' }
      else
        format.html { render :new }
        format.json { render json: @media.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @media.update(media_params)
        format.html { redirect_to medias_url(@media), notice: 'メディアを更新しました' }
      else
        format.html { render :edit }
        format.json { render json: @media.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @media.destroy
    respond_to do |format|
      format.html { redirect_to medias_url, notice: 'メディアを削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media
      @media = Medium.find(params[:id])
    end

    def media_params
      params.require(:medium).permit(:media_name, :media_image)
    end
end

class BlogsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blogs = Blog.all
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
      if @blog.save

      	if params[:blog][:image_photo]
	  File.binwrite("public/blog_images/#{@blog.id}.PNG", params[:blog][:image_photo].read)
	  @blog.update(image_photo: "#{@blog.id}.PNG" )
	else
	  flash[:danger] = "写真を指定できませんでした。"
	end

	flash[:success] = "作成できました"
        redirect_to @blog
      else
        flash[:danger] = "作成に失敗しました"
        render :new 
      end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
      if @blog.update(blog_params)
        
	if params[:blog][:image_photo]
	  File.binwrite("public/blog_images/#{@blog.id}.PNG", params[:blog][:image_photo].read)
          @blog.update(image_photo: "#{@blog.id}.PNG")
	else
          flash[:danger] = "写真を指定できませんでした。"
	end

	flash[:success] = "更新できました"
        redirect_to @blog
      else
        flash[:danger] = "更新に失敗しました"
        render :edit 
      end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'サブスクnewsの削除完了です！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :body, :image_photo, :admin_id)
    end
end

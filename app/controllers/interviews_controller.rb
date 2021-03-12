class InterviewsController < ApplicationController
  before_action :set_interview, only: [:show, :edit, :update, :destroy]
  # before_action :set_owner, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :interviews_lock, only: %i(new edit)

  # GET /interviews
  # GET /interviews.json
  def index
    @interviews = Interview.all
    @interviews_count = Interview.all.count
  end

  def interviews_index
    @interviews = @owner.interviews
  end

  # GET /interviews/1
  # GET /interviews/1.json
  def show
  end

  # GET /interviews/new
  def new
    @interview = Interview.new
  end

  # GET /interviews/1/edit
  def edit
  end

  # POST /interviews
  # POST /interviews.json
  def create
    @interview = Interview.new(interview_params)

    respond_to do |format|
      if @interview.save
        format.html { redirect_to interviews_url, notice: 'インタビューの新規登録完了です！' }
        format.json { render :index, status: :created, location: @interview }
      else
        format.html { render :new }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interviews/1
  # PATCH/PUT /interviews/1.json
  def update
    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to interviews_url, notice: 'インタビューの更新完了です！' }
        format.json { render :index, status: :ok, location: @interview }
      else
        format.html { render :edit }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interviews/1
  # DELETE /interviews/1.json
  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to interviews_url, notice: 'インタビューの削除完了です！' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
    end

    def set_owner
      @owner = Owner.find(params[:owner_id])
    end

    # Only allow a list of trusted parameters through.
    def interview_params
      params.require(:interview).permit(:owner_name, :shop_name, :content, :image_interview, :youtube_url, :music, :owner_id)
    end

    def interviews_lock
      if current_user.present?
        redirect_to root_url, notice: '権限がありません'
      end
    end
end

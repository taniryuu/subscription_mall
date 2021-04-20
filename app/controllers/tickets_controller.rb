class TicketsController < ApplicationController
  before_action :trial_period, only: :show

  def index
    @tickets = Ticket.all.paginate(page: params[:page], per_page: 10) # 案１みんなのチケットを表示
    # @ticket = Ticket.find_by(user_id: params[:user_id]) # 案２　一人のチケットを表示
  end

  def show
    @ticket = Ticket.find(params[:id])
    #user = User.find(@ticket.user_id)
    if @ticket.subscription_name.present?
      @subscription = Subscription.find_by(name: @ticket.subscription_name)
    elsif @ticket.private_store_name.present?
      @private_store = PrivateStore.find_by(name: @ticket.private_store_name)
    end
  end

  def user_have_ticket##経営者が持っているお店の発券中のチケットを持っている利用者一覧
    if current_owner.present?
      @tickets = Ticket.where(owner_name: current_owner.name).order("created_at ASC").paginate(page: params[:page], per_page: 10)
    elsif current_admin.present?
      @tickets = Ticket.where.not(owner_name: nil).order("created_at ASC").paginate(page: params[:page], per_page: 10)
    end
  end

  def new
    @ticket = Ticket.new
  end

  # 1回目のチケット発券
  def create
    @ticket = Ticket.new(ticket_params)
   if @ticket.save
     if params[:ticket][:private_store_name].present?
       private_store = PrivateStore.find_by(name: params[:ticket][:private_store_name])
       current_user.update!(issue_ticket_day: Date.today, private_store_id: private_store.id)
     else 
       current_user.update(issue_ticket_day: Date.today)
     end
     flash[:success] = "チケットを発券しました"
     redirect_to user_account_user_path(current_user), notice: 'チケットを発券しました。Myアカウントからチケット確認ボタンを押してチケットを使ってみましょう！'
   else
     flash[:danger] = "チケットが発券できませんでした"
     redirect_to root_path
   end
   #current_user.update(issue_ticket_day: Date.today)
  end

  # チケットを使うボタンを押した後の処理（使った日を入れる）（１回目以降ずっと）
  def update
    @ticket = Ticket.find_by(user_id: current_user.id)
    # @ticket_log = TicketLog.new(ticket_id: @ticket.id, use_ticket_day_log: use_ticket_params)
    if @ticket.update_attributes(use_ticket_params)
      current_user.update!(use_ticket_day: params[:ticket][:use_ticket_day]) if params[:ticket][:use_ticket_day].present?
      if @ticket.trial_last_check == "true"
        ticket_trial = "利用"
      else
        ticket_trial = "-"
      end
      TicketLog.create(
        use_ticket_day_log: @ticket.use_ticket_day, 
        owner_name: @ticket.owner_name,
        owner_email: @ticket.owner_email, 
        owner_phone_number: @ticket.owner_phone_number, 
        owner_store_information: @ticket.owner_store_information,
        subscription_name: @ticket.subscription_name, 
        category_id: @ticket.category_id, 
        private_store_name: @ticket.private_store_name, 
        subscription_fee: @ticket.subscription_fee,
        issue_ticket_day: @ticket.issue_ticket_day,
        user_id: @ticket.user_id, 
        price: @ticket.price, 
        trial: ticket_trial,
      )
      TicketMailer.ticket_email(@ticket).deliver_now
      redirect_to ticket_success_path
    else
      redirect_to root_path
    end
  end

  def edit_user_ticket
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(edit_user_ticket)
      flash[:success] = "チケットを発券しました"
      redirect_to user_account_user_path(current_user)
    else
      flash[:danger] = "チケットが発見できませんでした"
      redirect_to root_path
    end
    current_user.update(issue_ticket_day: Date.today)
  end

  # ２回目以降チケット発券
  def ticket_update_after_second_time
    @ticket = Ticket.find_by(user_id: current_user.id)
    if @ticket.update_attributes(update_ticket_params)
      if params[:ticket][:private_store_name].present?
        private_store = PrivateStore.find_by(name: params[:ticket][:private_store_name])
        current_user.update!(issue_ticket_day: Date.today, private_store_id: private_store.id, use_ticket_day: nil)
      else
	current_user.update(issue_ticket_day: Date.today)
      end
      flash[:success] = "チケットを発券しました"
      redirect_to user_account_user_path(current_user)
    else
      flash[:danger] = "チケットが発券できませんでした"
      redirect_to root_path
    end
  end

  def ticket_success
  end

  private

    def ticket_params
	    params.require(:ticket).permit(:owner_name, :owner_email, :owner_phone_number, :owner_store_information, :price, :trial, :trial_check, :trial_last_check, :trial_count, :subscription_name, :category_id, :private_store_name, :subscription_fee, :issue_ticket_day, :user_id)
    end

    def edit_user_ticket
      params.require(:ticket).permit(:issue_ticket_day, :user_id)
    end

    def use_ticket_params
      params.require(:ticket).permit(:use_ticket_day, :trial_last_check)
    end

    def update_ticket_params
	    params.require(:ticket).permit(:owner_name, :owner_email, :owner_phone_number, :owner_store_information, :price, :trial, :trial_check, :trial_last_check, :trial_count, :owner_payee, :subscription_name, :category_id, :private_store_name, :subscription_fee, :issue_ticket_day, :user_id)
    end

    #トライアルチケット削除
    def trial_period
      @ticket = Ticket.find(params[:id])
      if @ticket.present? && current_user.price === 1000
        if
          @ticket.trial_count.nil? || @ticket.trial_count == 2
        elsif @ticket.trial_count === 3
          @ticket.destroy
          current_user.update(issue_ticket_day: nil)
          flash[:success] = "トライアルチケットは期限切れになりました"
          user_account_user_path(current_user)
        elsif  Date.today > @ticket.created_at.since(7.days)
          @ticket.destroy
          current_user.update(issue_ticket_day: nil)
          flash[:success] = "トライアルチケットは期限切れになりました"
          user_account_user_path(current_user)
        end
      end
    end
end

class TicketsController < ApplicationController

  def index
    @tickets = Ticket.all # 案１みんなのチケットを表示
    # @ticket = Ticket.find_by(user_id: params[:user_id]) # 案２　一人のチケットを表示
  end

  def show
    @ticket = Ticket.find_by(user_id: params[:id])
  end

  def new
    @ticket = Ticket.new
  end
  
  # 1回目のチケット発券
  def create
    @ticket = Ticket.new(ticket_params)

   if @ticket.save
       flash[:success] = "チケットを発券しました"
      redirect_to user_account_user_path(current_user)
   else
       flash[:danger] = "チケットが発券できませんせした"
       redirect_to root_path
   end
   current_user.update(issue_ticket_day: Date.today)
  end

  # チケットを使うボタンを押した後の処理（使った日を入れる）（１回目以降ずっと）
  def update
    @ticket = Ticket.find_by(user_id: params[:user_id])
    # @ticket_log = TicketLog.new(ticket_id: @ticket.id, use_ticket_day_log: use_ticket_params)
    if @ticket.update_attributes(use_ticket_params)
      TicketLog.create(use_ticket_day_log: @ticket.use_ticket_day, ticket_id: @ticket.id, owner_name: @ticket.owner_name, 
		       owner_email: @ticket.owner_email, owner_phone_number: @ticket.owner_phone_number, owner_store_information: @ticket.owner_store_information, 
		       subscription_name: @ticket.subscription_name, private_store_name: @ticket.private_store_name, subscription_fee: @ticket.subscription_fee, 
		       issue_ticket_day: @ticket.issue_ticket_day,user_id: @ticket.user_id)
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
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(update_ticket_params)
      flash[:success] = "チケットを発券しました"
      redirect_to user_account_user_path(current_user)
    else
      flash[:danger] = "チケットが発見できませんでした"
      redirect_to root_path
    end
    current_user.update(issue_ticket_day: Date.today)
  end

  def ticket_success
  end

  private

    def ticket_params
	    params.require(:ticket).permit(:owner_name, :owner_email, :owner_phone_number, :owner_store_information, :owner_payee, :subscription_name, :private_store_name, :subscription_fee, :issue_ticket_day, :user_id)
    end

    def edit_user_ticket
      params.require(:ticket).permit(:issue_ticket_day, :user_id)
    end

    def use_ticket_params
      params.require(:ticket).permit(:use_ticket_day)
    end

    def update_ticket_params
	    params.require(:ticket).permit(:owner_name, :owner_email, :owner_phone_number, :owner_store_information, :owner_payee, :subscription_name, :private_store_name, :subscription_fee, :issue_ticket_day, :user_id)
    end
end

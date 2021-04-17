class TicketLogsController < ApplicationController
  def index
    if current_user.present?
      @ticket_logs = TicketLog.where(user_id: current_user.id).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    elsif current_owner.present?
      @ticket_logs = TicketLog.where(owner_name: current_owner.name).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      # @ticket_logs = TicketLog.where(Ticket.find_by(user_id: current_user.id)).paginate(page: params[:page], per_page: 10)
    elsif current_admin.present?
      @ticket_logs = if params[:owner_name]
        TicketLog.search(params[:owner_name]).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      else
        TicketLog.all.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
      end
    end
  end

  def destroy
    @ticket_log = TicketLog.find(params[:id])
    if@ticket_log.destroy
      flash[:notice] = "履歴を削除しました"
    end
    render :index
  end
end

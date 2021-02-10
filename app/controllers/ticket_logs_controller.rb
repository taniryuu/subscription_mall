class TicketLogsController < ApplicationController
  def index
    if current_user.present?
      @ticket_logs = TicketLog.where(ticket_id: Ticket.find_by(user_id: current_user.id).id)
    elsif current_admin.present?
      @ticket_logs = TicketLog.all
    end
  end
end

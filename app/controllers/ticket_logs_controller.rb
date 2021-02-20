class TicketLogsController < ApplicationController
  def index
    if current_user.present?
      @ticket_logs = TicketLog.where(user_id: current_user.id)
    elsif current_owner.present?
      @ticket_logs = TicketLog.where(owner_email: current_owner.email)
      @ticket_logs = TicketLog.where(ticket_id: Ticket.find_by(user_id: current_user.id).id)
    elsif current_admin.present?
      @ticket_logs = TicketLog.all
    end
  end
end

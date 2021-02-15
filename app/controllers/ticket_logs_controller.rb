class TicketLogsController < ApplicationController
  def index
    if current_user.present?
<<<<<<< HEAD
      @ticket_logs = TicketLog.where(user_id: current_user.id)
    elsif current_owner.present?
      @ticket_logs = TicketLog.where(owner_email: current_owner.email)
=======
      @ticket_logs = TicketLog.where(ticket_id: Ticket.find_by(user_id: current_user.id).id)
>>>>>>> 26630e464680f39b7b26ee905c89e5738f771549
    elsif current_admin.present?
      @ticket_logs = TicketLog.all
    end
  end
end

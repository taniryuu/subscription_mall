class TicketLogsController < ApplicationController
  def index
    @ticket_logs = TicketLog.all
  end
end

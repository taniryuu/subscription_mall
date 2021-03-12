class TicketMailer < ApplicationMailer
  default from: 'megurumee@gmail.com'

  def ticket_email(ticket)
    @ticket = ticket
    @user = User.find_by(id: @ticket.user_id)
    mail(to: @ticket.owner_email, subject: "#{@ticket.owner_name}さんのお店でチケットの利用がありました。")
  end

end
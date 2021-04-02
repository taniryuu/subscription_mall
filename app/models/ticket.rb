class Ticket < ApplicationRecord
  belongs_to :user
  # has_many :ticket_logs, dependent: :destroy
end

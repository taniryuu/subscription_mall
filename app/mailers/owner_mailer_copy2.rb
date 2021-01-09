class OwnerMailer < ActionMailer::Base
  default from: "from@exaple.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.owner_mailer.registration_confirmation.subject
  #
  def registration_confirmation
    @greeting = "Hi"

    mail to: "ruffini47@gmail.com"
  end
end

# Preview all emails at http://localhost:3000/rails/mailers/owner_mailer
class OwnerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/owner_mailer/registration_confirmation
  def registration_confirmation
    OwnerMailer.registration_confirmation
  end

end

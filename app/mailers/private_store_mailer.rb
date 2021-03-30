class PrivateStoreMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notification_email
    @private_store = params[:private_store]
    mail(to: 'ruffini47@gmail.com', subject: '新規private_storeを作成しました')
  end

end

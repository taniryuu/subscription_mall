class PrivateStoreMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notification_email
    @private_store = params[:private_store]
    @new = params[:new]
    if @new == "true"
      mail(to: 'megurumee@gmail.com', subject: '個人店舗が新規作成されました')
    else
      mail(to: 'megurumee@gmail.com', subject: '個人店舗が編集されました')
    end
  end

end

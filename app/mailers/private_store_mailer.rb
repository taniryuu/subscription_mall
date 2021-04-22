class PrivateStoreMailer < ApplicationMailer
  default from: ENV['SEND_MAIL']

  def notification_email
    @private_store = params[:private_store]
    @new = params[:new]
    @url  = 'https://www.megurumee.com/'
    if @new == "true"
      mail(to: ENV['SEND_MAIL'], subject: '個人店舗が審査申請されました')
    else
      mail(to: ENV['SEND_MAIL'], subject: '個人店舗が編集されました')
    end
  end

  def judging_email
    @private_store = params[:private_store]
    @owner = Owner.find_by(id: @private_store.owner_id)
    @new = params[:new]
    @url  = 'https://www.megurumee.com/'
    if @new == "承認"
      mail(to: @owner.email, subject: '審査結果報告')
    else
      mail(to: @owner.email, subject: '個人店舗が編集されました')
    end
  end

  def takeout_email
    @user = User.find(params[:id])
    @private_store = PrivateStore.find(params[:private_store_id])
    mail(to: @private_store.email, subject: "テイクアウトの注文が入りました")
  end
end

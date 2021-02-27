class SmsController < ApplicationController
  before_action :authenticate_user!, :sms_auth_true?

  include RandomValueGenerator

  require 'twilio-ruby'

  #SMSの送信
  def new
    send_phone_number = PhonyRails.normalize_number current_user.phone_number, country_code:'JP'
    session[:secure_code] = random_number_generator(6)

    # twilioのMessagingAPIを使用してSMSに認証コード送信
    begin
      client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
      result = client.messages.create(
        from: ENV["TWILIO_PHONE_NUMBER"],
        to: '+81-090-8125-1228',
        body: "認証番号：#{session[:secure_code]} この番号を巡グルメの画面で入力してください。"
      )
    rescue Twilio::REST::RestError => e
      @messages = "エラーコード[#{e.code}] ：” #{e.message}”"
    end
  end

  # 入力チェック
  def confirm
    if params[:secure_code].present?
      if session[:secure_code] == params[:secure_code]
        current_user.update!(sms_auth: true)
        redirect_to new_user_plan_url
      else
        @messages = '認証番号が一致しませんでした'
        render root_url
      end
    else
      @messages = '認証番号を入力してください'
      render root_url
    end
  end

  # すでに認証済みならプラン選択画面に遷移
  def sms_auth_true?
    if current_user.sms_auth?
      redirect_to new_user_plan_url
    end
  end
end

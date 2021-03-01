if Rails.env.development? || Rails.env.test?
  Rails.configuration.paypay = {
    :apikey => ENV['PAYPAY_API_KEY'],
    :apisecret      => ENV['PAYPAY_SECRET_KEY'],
    :merchantid      => ENV['MERCHANT_ID']
  }
end
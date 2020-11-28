json.extract! cupon, :id, :product, :discount, :status, :image, :writing, :limit, :reason, :review_id, :owner_id, :user_id, :admin_id, :created_at, :updated_at
json.url cupon_url(cupon, format: :json)

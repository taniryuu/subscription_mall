json.extract! subscription, :id, :name, :title, :detail, :image_subscription, :price, :subscription_detail, :category_name, :owner_id, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)

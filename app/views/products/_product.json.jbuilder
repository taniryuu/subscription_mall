json.extract! product, :id, :title, :content, :price, :subscription_detail, :subscription_id, :owner_id, :user_id, :admin_id, :created_at, :updated_at
json.url product_url(product, format: :json)

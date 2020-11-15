json.extract! review, :id, :name, :content, :score, :user_id, :created_at, :updated_at
json.url review_url(review, format: :json)

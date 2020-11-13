json.extract! blog, :id, :title, :body, :image_photo, :admin_id, :created_at, :updated_at
json.url blog_url(blog, format: :json)

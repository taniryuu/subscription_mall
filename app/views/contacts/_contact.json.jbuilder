json.extract! contact, :id, :name, :email, :subject, :message, :user_id, :owner_id, :created_at, :updated_at
json.url contact_url(contact, format: :json)

json.extract! food, :id, :user_id, :name, :caption, :address, :picture, :created_at, :updated_at
json.url food_url(food, format: :json)

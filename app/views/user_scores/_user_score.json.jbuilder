json.extract! user_score, :id, :user_id, :score, :year, :created_at, :updated_at
json.url user_score_url(user_score, format: :json)
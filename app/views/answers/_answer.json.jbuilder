json.extract! answer, :id, :user_id, :puzzle_id, :answer, :answer_orginal, :success, :created_at, :updated_at
json.url answer_url(answer, format: :json)
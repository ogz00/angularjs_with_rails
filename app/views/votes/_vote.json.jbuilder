json.extract! vote, :id, :puzzle_id, :user_id, :popularity, :difficulty, :created_at, :updated_at
json.url vote_url(vote, format: :json)
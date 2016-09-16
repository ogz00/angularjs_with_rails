json.extract! comment, :id, :puzzle_id, :user_id, :subject, :message, :publish, :isCommentTop, :created_at, :updated_at
json.url comment_url(comment, format: :json)
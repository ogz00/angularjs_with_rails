json.extract! puzzle, :id, :no, :name, :question, :answer, :isTabled, :publish_date, :created_at, :year, :publish, :score
json.url puzzle_url(puzzle, format: :json)
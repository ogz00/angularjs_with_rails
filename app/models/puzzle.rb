class Puzzle < ActiveRecord::Base
  has_attached_file :image,
                    :bucket => ENV['S3_BUCKET_NAME'],
                    :path => "/u:idh:hash.:extension",
                    :hash_secret => 'trywqteryingridmichaelsonasdasd'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :comments, :dependent => :delete_all

  def as_json(options = {})
    super(options.merge({except: [:answer, :timestamp, :updated_at, :created_at]}))
  end


  def self.right_answers(puzzleId)
    sql = "SELECT puzzle_id
			FROM answers a
			WHERE a.puzzle_id= '#{puzzleId}' AND answer = (SELECT answer FROM puzzles WHERE id = '#{puzzleId}');"

    result = ActiveRecord::Base.connection.execute(sql)
    result.to_a.length
  end

  def self.total_answers(puzzleId)
    sql ="SELECT id FROM answers a WHERE puzzle_id='#{puzzleId}';"
    result = ActiveRecord::Base.connection.execute(sql)
    result.to_a.length
  end

  def correct_answer
    answer
  end

  def qscore
    score
  end
end

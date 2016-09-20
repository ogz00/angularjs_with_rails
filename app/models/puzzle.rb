class Puzzle < ActiveRecord::Base
  has_attached_file :image,
                    :bucket => ENV['S3_BUCKET_NAME'],
                    :path => "/u:idh:hash.:extension",
                    :hash_secret => 'trywqteryingridmichaelsonasdasd'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :comments, :dependent => :delete_all

  def as_json(options = {})
    super(options.merge({except: [:answer, :timestamp, :updated_at, :created_at, :isTabled]}))
  end


  def self.rightAnswerRatio(puzzleId)
    sql = "SELECT puzzle_id
			FROM answer a
			WHERE a.puzzle_id= '#{puzzleId}' AND answer = (SELECT answer FROM puzzle WHERE puzzle_id= '#{puzzleId}'
			AND NOT EXISTS (
				SELECT *
				FROM answer b
				WHERE b.puzzle_id = a.puzzle_id
				AND a.user_id = b.user_id
				AND b.created_at>a.created_at
				));"

    ActiveRecord::Base.connection.execute(sql)
  end

  def correct_answer
    answer
  end

  def qscore
    score
  end
end

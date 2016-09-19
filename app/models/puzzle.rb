class Puzzle < ActiveRecord::Base
  has_attached_file :image,
                    :bucket => ENV['S3_BUCKET_NAME'],
                    :path => "/u:idh:hash.:extension",
                    :hash_secret => 'trywqteryingridmichaelsonasdasd'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :comments, :dependent => :delete_all

  def as_json(options = {})
    super(options.merge({ except: [:answer, :timestamp, :updated_at, :created_at, :isTabled] }))
  end

  def correct_answer
    answer
  end

  def qscore
    score
  end
end

class Comment < ActiveRecord::Base
  belongs_to :puzzle
  belongs_to :user

  def as_json(options = {})
    super(options.merge({ except: [:publish, :isCommentTop, :updated_at], include: :user }))
  end

  def self.current(puzzle_id)
    Comment
        .where(:puzzle_id => puzzle_id)
        .where(:publish => true)
  end

  def self.forAdmin(puzzle_id)
    Comment.where(:puzzle_id =>  puzzle_id)
  end

end

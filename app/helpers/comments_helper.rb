module CommentsHelper

  def self.current(puzzle_id)
    Comment.current(puzzle_id.to_i)
  end

  def self.admin(puzzle_id)
    Comment.forAdmin(puzzle_id)
  end
end

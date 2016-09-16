class Vote < ActiveRecord::Base
  belongs_to :puzzle
  belongs_to :user


  def self.average_by_popularity(puzzle_id)
    Vote.where(puzzle_id: puzzle_id)
        .average(:popularity)
  end


  def self.average_by_difficulty(puzzle_id)
    Vote.where(puzzle_id: puzzle_id)
        .average(:difficulty)
  end


=begin
Vote
        .select('(sum(popularity) / COUNT(popularity)) AS popular,
    (sum(difficulty) / COUNT(difficulty)) AS difficult FROM votes')
        .where(:puzzle_id => puzzle_id)

  Vote
      .select(:popularity, :difficulty)
      .average(:popularity, :group => :puzzle)
      .average(:difficulty, :group => :puzzle)
      .where(:puzzle => puzzle_id)
=end
end

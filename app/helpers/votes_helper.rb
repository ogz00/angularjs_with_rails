module VotesHelper

  def self.average_by_popularity_and_difficulty(puzzle_id)
    stats = []
    popularity = Vote.average_by_popularity(puzzle_id)
    difficulty = Vote.average_by_difficulty(puzzle_id)
    if !popularity.nil?
      stats.push popularity*25
    else
      stats.push 0.0
    end

    if !difficulty.nil?
      stats.push difficulty*25
    else
      stats.push 0.0
    end
    return stats
  end
end

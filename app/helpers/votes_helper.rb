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

  def self.popularity_all_puzzles
    year = Time.now.year
    @puzzle_popularity = []
    @puzzles = Puzzle.where(:year => year)
    @puzzles.each do |puzzle|
      popularity =  Vote.average_by_popularity(puzzle.id)
      if !popularity.nil?
        popularity = popularity*25
      else
        popularity = 0.0
      end
      @puzzle_popularity << {:id => puzzle.id, :no => puzzle.no, :name => puzzle.name, :popularity => popularity.round}
    end
    puts "asdasd #{@puzzle_popularity.to_json}"
    @puzzle_popularity.to_json
  end
end

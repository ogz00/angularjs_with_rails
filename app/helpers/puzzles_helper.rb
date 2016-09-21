module PuzzlesHelper

  require 'date'

  def self.current
    year = Time.now.year
    now = DateTime.now
    Puzzle
        .where('year = ?', year)
        .where('publish = ?', true)
        .where('publish_date < ?', now)
        .order('no DESC')
  end


  def self.calculate_score(puzzleId)
    right_answer = Puzzle.right_answers(puzzleId)
    total_answer = Puzzle.total_answers(puzzleId)
    if total_answer != 0
      return 100 - (right_answer*100 / total_answer)
    else
      return -1
    end
  end

end

class PuzzleAnsweredError < StandardError;
end
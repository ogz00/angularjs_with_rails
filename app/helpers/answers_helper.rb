module AnswersHelper

  def self.findUsersPrevAnswers(userId, puzzleId)
    Answer.where(:user_id => userId)
        .where(:puzzle_id => puzzleId)
  end


  def self.calculateBonus(answer)
    @puzzle = Puzzle.find(answer.puzzle_id)
    now = Time.now.getutc
    puts "now #{now}"
    puts "publish_date #{@puzzle.publish_date}"
    time_diff = now - @puzzle.publish_date
    puts "time_diff #{time_diff}"
    diff_days = time_diff / (3600 * 24)
    puts "diff_days #{diff_days}"
    bonus = if diff_days < 6 then 6 - diff_days else 0 end
    return bonus
  end
end

module AnswersHelper

  def self.findUsersPrevAnswers(userId, puzzleId)
    Answer.where(:user_id => userId)
        .where(:puzzle_id => puzzleId)
  end
end

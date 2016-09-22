module UserScoresHelper

  def self.calculate_user_scores

    year = Time.now.year
    all_puzzles = Puzzle.where(:year => year)
    @all_answers = Answer.all
    user_ids = []
    this_year_answers = []

    @all_answers.each do |answer|
      if answer.puzzle.year == year
        this_year_answers << answer
      end
    end

    this_year_answers.each do |answer|
      user_ids << answer.user_id
    end

    user_ids.uniq.each do |userId|
      user_answers = []
      answered_puzzles = []
      user_score = 0

      all_puzzles.each do |puzzle|
        @answer = Answer.where(:puzzle_id => puzzle.id)
                      .where(:user_id => userId)
        unless @answer.empty?
          answered_puzzles << puzzle
          user_answers << @answer[0]
        end
      end
      user_answers.each do |answer|
        answered_puzzles.each do |puzzle|
          if puzzle.id == answer.puzzle_id && answer.answer.to_s == puzzle.answer.to_s
            user_score += (puzzle.score + answer.bonus)
          end
        end
      end
      @user_old_score = UserScore.where(:user_id => userId)
                            .where(:year => year)
      unless @user_old_score.empty?
        @user_old_score[0].update(:score => user_score)
      else
        @user_score_object = UserScore.new(:user_id => userId, :score => user_score, :year => year)
        @user_score_object.save
      end


    end
    return UserScore.where(:year => year)
               .order('score desc')
  end


end

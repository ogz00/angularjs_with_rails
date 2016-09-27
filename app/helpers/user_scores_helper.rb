module UserScoresHelper


  def self.calculate_user_scores(*args)

    year = Time.now.year

    @all_answers = Answer.all

    user_ids = []
    this_year_answers = []
    @all_puzzles = []
    @all_answers.each do |answer|
      if answer.puzzle.year == year
        this_year_answers << answer
      end
    end

    this_year_answers.each do |answer|
      user_ids << answer.user_id
    end

    if args.size == 0
      @all_puzzles = PuzzlesHelper.current
    else
      args[0].each do |id|
        @all_puzzles << Puzzle.find(id)
      end
    end

    user_ids.uniq.each do |userId|
      user_answers = []
      answered_puzzles = []
      user_score = 0

      @all_puzzles.each do |puzzle|
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
      if args.size == 0

        unless @user_old_score.empty?
          @user_old_score[0].update(:score => user_score)
        else
          @user_score_object = UserScore.new(:user_id => userId, :score => user_score, :year => year, :tabled_score => 0)
          puts "new asdasdasdasd"
          @user_score_object.save
        end

      else
        unless @user_old_score.empty?
          @user_old_score[0].update(:tabled_score => user_score)
        else
          puts "THERE IS NO OLD SCORE"
        end
        @oldTabledPuzzles = Puzzle.where(:isTabled => true)
        @oldTabledPuzzles.update_all(:isTabled => false)

        @all_puzzles.each do |puzzle|
          @puzzle = Puzzle.find(puzzle.id)
          @puzzle.update(:isTabled => true)

        end
      end
    end

    if args.size == 0
      return UserScore.where(:year => year)
                 .order('score desc')
    else
      return UserScore.where(:year => year)
                 .order('tabled_score desc')
    end

  end


end

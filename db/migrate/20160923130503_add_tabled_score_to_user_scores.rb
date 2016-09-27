class AddTabledScoreToUserScores < ActiveRecord::Migration
  def change
    add_column :user_scores, :tabled_score, :integer
  end
end

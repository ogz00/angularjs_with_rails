class CreateTabledUserScores < ActiveRecord::Migration
  def change
    create_table :tabled_user_scores do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :score

      t.timestamps null: false
    end
  end
end

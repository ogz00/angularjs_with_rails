class CreateUserScores < ActiveRecord::Migration
  def change
    create_table :user_scores do |t|
      t.integer :user_id
      t.integer :score
      t.integer :year

      t.timestamps null: false
    end
  end
end

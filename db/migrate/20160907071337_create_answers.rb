class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :puzzle, index: true, foreign_key: true
      t.string :answer
      t.string :answer_orginal
      t.boolean :success

      t.timestamps null: false
    end
  end
end

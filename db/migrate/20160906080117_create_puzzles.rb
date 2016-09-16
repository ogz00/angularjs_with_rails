class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.date :date
      t.integer :no
      t.string :name
      t.text :question
      t.text :answer
      t.date :maraton
      t.boolean :isTabled
      t.datetime :timestamp

      t.timestamps null: false
    end
  end
end

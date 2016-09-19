class AddColumnToPuzzle < ActiveRecord::Migration
  def change
    add_attachment :puzzles, :image
    add_column :puzzles, :score, :integer
  end
end

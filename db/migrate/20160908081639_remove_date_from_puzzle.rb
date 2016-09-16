class RemoveDateFromPuzzle < ActiveRecord::Migration
  def change
    remove_column :puzzles, :date
  end
end

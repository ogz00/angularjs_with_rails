class DeleteColumnTimestampOnPuzzle < ActiveRecord::Migration
  def change
    remove_column :puzzles, :timestamp
  end
end

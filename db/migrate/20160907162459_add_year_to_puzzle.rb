class AddYearToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :year, :integer
  end
end

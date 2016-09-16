class AddPublishedToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :publish, :boolean
  end
end

class RenameColumnMarathon < ActiveRecord::Migration
  def change
    rename_column :puzzles, :maraton, :publish_date
  end
end

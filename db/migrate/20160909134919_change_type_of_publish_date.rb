class ChangeTypeOfPublishDate < ActiveRecord::Migration
  def change
    change_column :puzzles, :publish_date, :datetime
  end
end

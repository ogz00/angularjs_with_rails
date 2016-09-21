class AddBonusToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :bonus, :integer
  end
end

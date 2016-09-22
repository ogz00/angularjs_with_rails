class AddRelationshipsToUserScore < ActiveRecord::Migration
  def change
    remove_column :user_scores, :user_id
    add_reference :user_scores, :user, index: true
  end
end

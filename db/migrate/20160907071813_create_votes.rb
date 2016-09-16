class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :puzzle, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :popularity
      t.integer :difficulty

      t.timestamps null: false
    end
  end
end

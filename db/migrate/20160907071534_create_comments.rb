class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :puzzle, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :subject
      t.text :message
      t.boolean :publish
      t.boolean :isCommentTop

      t.timestamps null: false
    end
  end
end

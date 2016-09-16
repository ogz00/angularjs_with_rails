class AddFiledsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_column :users, :birth_date, :date
    add_column :users, :phone, :string, :limit => 25
    add_column :users, :address, :text, :limit => 1000
  end
end
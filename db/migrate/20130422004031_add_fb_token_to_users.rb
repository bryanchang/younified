class AddFbTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fbtoken, :string
  end
end

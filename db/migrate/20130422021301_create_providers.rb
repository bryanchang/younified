class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :uid
      t.string :token
      t.integer :user_id
      t.string :provider

      t.timestamps
    end
  end
end

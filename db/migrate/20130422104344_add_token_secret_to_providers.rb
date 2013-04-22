class AddTokenSecretToProviders < ActiveRecord::Migration
  def change
  	add_column :providers, :token_secret, :string
  end
end

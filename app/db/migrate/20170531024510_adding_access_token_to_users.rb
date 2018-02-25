class AddingAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_token, :string, null:false, default: "8a19e072"
    add_index :users, :access_token, unique: false
  end
end

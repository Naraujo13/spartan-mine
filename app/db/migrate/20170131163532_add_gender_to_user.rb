class AddGenderToUser < ActiveRecord::Migration
  def change
      add_column :users, :gender, :string, null: false, default: "m"
      add_column :users, :address, :string, null: false, default: ""
      add_column :users, :postal_code, :string, null: false, default: ""
  end
end

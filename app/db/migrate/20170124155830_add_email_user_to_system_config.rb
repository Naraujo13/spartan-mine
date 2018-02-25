class AddEmailUserToSystemConfig < ActiveRecord::Migration
  def change
      add_column :system_configs, :email_user, :string, null: false, default: "email@athome.com"
      add_column :system_configs, :email_password, :string, null: false, default: "password"
  end
end

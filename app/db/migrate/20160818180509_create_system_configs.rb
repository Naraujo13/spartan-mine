class CreateSystemConfigs < ActiveRecord::Migration
  def change
    create_table :system_configs do |t|
      t.string :name_sort
      t.string :name_company
      t.string :address_company
      t.string :country_company
      t.string :email_company
      t.string :phone_company
      t.string :terms_of_user_last_change
      t.string :privacity_last_change
      t.string :at_home_version_repository
      t.string :google_maps_id
      t.string :google_analytics_id
      t.string :system_color
      t.string :system_color_disabled
      t.string :system_danger_color
      t.string :country_code

      t.timestamps
    end
  end
end

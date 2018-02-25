class CreateSystemGroupAccessPeople < ActiveRecord::Migration
  def change
    create_table :system_group_access_people do |t|
      t.references :users, index: true
      t.references :system_group_access, index: true

      t.timestamps
    end
  end
end

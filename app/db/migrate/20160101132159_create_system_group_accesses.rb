class CreateSystemGroupAccesses < ActiveRecord::Migration
  def change
    create_table :system_group_accesses do |t|
      t.string :name
      t.string :description
      t.boolean :active

      t.timestamps
    end
  end
end

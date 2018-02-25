class CreateSystemGroupAccessPrograms < ActiveRecord::Migration
  def change
    create_table :system_group_access_programs do |t|
      t.references :system_group_accesses, index: true
      t.references :system_programs, index: true

      t.timestamps
    end
  end
end

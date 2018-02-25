class CreateSystemBugs < ActiveRecord::Migration
  def change
    create_table :system_bugs do |t|
      t.text :problem
      t.references :bug_status, index: true
      t.integer :user_id
      t.timestamps
    end
  end
end

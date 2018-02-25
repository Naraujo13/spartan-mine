class CreateSystemBugMessages < ActiveRecord::Migration
  def change
    create_table :system_bug_messages do |t|
      t.text :message
      t.boolean :displayed
      t.string :message_from
      t.string :message_to
      t.references :bug, index: true
      t.integer :admin_id
      t.timestamps
    end
  end
end

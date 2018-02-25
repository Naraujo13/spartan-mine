class FixingBugIdReferences < ActiveRecord::Migration
  def change
    remove_column :system_bug_messages, :bug_id
    add_reference :system_bug_messages, :system_bug, index: true
  end
end

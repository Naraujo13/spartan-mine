class CreateSystemBugStatuses < ActiveRecord::Migration
  def change
    create_table :system_bug_statuses do |t|
      t.string :description

      t.timestamps
    end
  end
end

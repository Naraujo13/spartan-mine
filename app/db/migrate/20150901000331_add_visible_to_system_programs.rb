class AddVisibleToSystemPrograms < ActiveRecord::Migration
  def change
    add_column :system_programs, :visible, :boolean, :default => true
  end
end

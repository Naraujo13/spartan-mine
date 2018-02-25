class ChangeSystemCategoryProgramNameToLocateLabel < ActiveRecord::Migration
  def change
      rename_column :system_category_programs, :name, :locate_label
      add_column :system_category_programs, :position, :integer, null: false, :default => 1
  end
end

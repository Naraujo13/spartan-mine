class ChangeNameColumnAtProgram < ActiveRecord::Migration
  def change
    rename_column :system_programs, :nome, :name
  end
end

class FixDescriptionColumnAtPrograms < ActiveRecord::Migration
  def change
    rename_column :system_programs, :descricao, :description
  end
end

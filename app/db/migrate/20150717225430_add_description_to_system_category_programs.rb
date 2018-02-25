class AddDescriptionToSystemCategoryPrograms < ActiveRecord::Migration
  def change
    add_column :system_category_programs, :description, :string
  end
end

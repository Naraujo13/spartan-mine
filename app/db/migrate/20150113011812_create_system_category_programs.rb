class CreateSystemCategoryPrograms < ActiveRecord::Migration
  def change
    create_table :system_category_programs do |t|
      t.string :name
      t.string :icon

      t.timestamps
    end
  end
end

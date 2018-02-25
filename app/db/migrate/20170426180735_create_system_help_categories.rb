class CreateSystemHelpCategories < ActiveRecord::Migration
  def change
    create_table :system_help_categories do |t|
      t.string :description

      t.timestamps
    end
  end
end

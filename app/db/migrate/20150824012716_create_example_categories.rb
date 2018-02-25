class CreateExampleCategories < ActiveRecord::Migration
  def change
    create_table :example_categories do |t|
      t.text :description

      t.timestamps
    end
  end
end

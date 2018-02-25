class CreateExampleTags < ActiveRecord::Migration
  def change
    create_table :example_tags do |t|
      t.string :title
      t.boolean :active

      t.timestamps
    end
  end
end

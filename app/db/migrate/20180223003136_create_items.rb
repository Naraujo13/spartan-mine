class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_id
      t.string :name
      t.references :collection
      t.datetime :year
      t.string :status
      t.float :lenght
      t.float :height
      t.float :width
      t.float :thickness
      t.datetime :aquisition_date
      t.float :outer_circumference
      t.float :inner_circumference
      t.float :weight
      t.string :conservation_state
      t.string :biography
      t.string :description

      t.timestamps null: false
    end
    add_foreign_key :items, :collections, on_update: :cascade, on_delete: :cascade
  end
end

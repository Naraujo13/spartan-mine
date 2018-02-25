class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :collection_id
      t.references :museum
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :collections, :museums, on_update: :cascade, on_delete: :cascade
  end
end

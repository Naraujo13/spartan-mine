class CreateMediafiles < ActiveRecord::Migration
  def change
    create_table :mediafiles do |t|
      t.references :item
      t.string :file

      t.timestamps null: false
    end
    add_foreign_key :mediafiles, :items, on_update: :cascade, on_delete: :cascade
  end
end

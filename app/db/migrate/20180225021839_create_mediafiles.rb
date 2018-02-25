class CreateMediafiles < ActiveRecord::Migration
  def change
    create_table :mediafiles do |t|
      t.references :user
      t.references :item
      t.string :name
      t.string :file

      t.timestamps null: false
    end
    add_foreign_key :mediafiles, :users, on_update: :cascade, on_delete: :cascade
    add_foreign_key :mediafiles, :items, on_update: :cascade, on_delete: :cascade
  end
end

class CreateMuseums < ActiveRecord::Migration
  def change
    create_table :museums do |t|
      t.string :cod_museum
      t.string :name
      t.references :director
      t.references :technician
      t.string :address
      t.string :phone
      t.string :opening_hours
      t.string :description

      t.timestamps null: false
    end
    add_foreign_key :museums, :users, column: :director_id, primary_key: :id, on_update: :cascade, on_delete: :restrict
    add_foreign_key :museums, :users, column: :technician_id, primary_key: :id, on_update: :cascade, on_delete: :restrict
  end
end

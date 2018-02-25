class CreateSystemHelps < ActiveRecord::Migration
  def change
    create_table :system_helps do |t|
      t.string :name
      t.references :system_help_category, index: true
      t.string :sort_description
      t.integer :like
      t.string :type
      t.text :post
      t.integer :viewed
      t.string :link
      t.boolean :featured

      t.timestamps
    end
  end
end

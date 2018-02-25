class CreateSystemFiles < ActiveRecord::Migration
  def change
    create_table :system_files do |t|
      t.string :name
      t.string :original_name
      t.string :path
      t.string :content_type
      t.references :user, index: true
      t.boolean :public

      t.timestamps
    end
  end
end

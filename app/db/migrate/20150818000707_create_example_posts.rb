class CreateExamplePosts < ActiveRecord::Migration
  def change
    create_table :example_posts do |t|
      t.string :title
      t.string :description
      t.text :content
      t.date :publish_at
      t.boolean :public
      t.integer :plus_one
      t.string :url_image
      
      t.timestamps
    end
  end
end

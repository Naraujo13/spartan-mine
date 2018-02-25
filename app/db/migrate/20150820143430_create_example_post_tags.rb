class CreateExamplePostTags < ActiveRecord::Migration
  def change
    create_table :example_post_tags do |t|
      t.references :example_posts, index: true
      t.references :example_tags, index: true

      t.timestamps
    end
  end
end

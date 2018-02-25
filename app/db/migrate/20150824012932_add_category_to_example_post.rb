class AddCategoryToExamplePost < ActiveRecord::Migration
  def change
    add_reference :example_posts, :example_category, index: true
  end
end

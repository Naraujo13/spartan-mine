class CreateSystemAccessToNestedResources < ActiveRecord::Migration
  def change
    create_table :system_access_to_nested_resources do |t|
      t.references :user, index: true
      t.string :path

      t.timestamps
    end
  end
end

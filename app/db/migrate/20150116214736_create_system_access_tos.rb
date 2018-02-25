class CreateSystemAccessTos < ActiveRecord::Migration
  def change
    create_table :system_access_tos do |t|
      t.references :user, index: true
      t.references :program, index: true

      t.timestamps
    end
  end
end

class CreateSystemPrograms < ActiveRecord::Migration
  def change
    create_table :system_programs do |t|
      t.string :nome
      t.string :descricao
      t.string :path
      t.references :category_program, index: true
      t.string :icon

      t.timestamps
    end
  end
end

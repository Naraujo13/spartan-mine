class CreateSystemVouchers < ActiveRecord::Migration
  def change
    create_table :system_vouchers do |t|
      t.string :voucher
      t.datetime :dt_expire
      t.string :email
      t.string :pricing
      t.string :first_name
      t.boolean :voucher_used, null: false, default: false
      t.references :user, index: true

      t.timestamps
    end
    add_index :system_vouchers, :voucher, unique: true
  end
end

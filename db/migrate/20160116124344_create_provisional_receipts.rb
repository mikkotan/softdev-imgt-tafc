class CreateProvisionalReceipts < ActiveRecord::Migration
  def change
    create_table :provisional_receipts do |t|
      t.belongs_to :transaction, index: true
      t.text :paid_items
      t.float :amount_paid
      t.string :receipt_no

      t.timestamps null: false
    end
  end
end

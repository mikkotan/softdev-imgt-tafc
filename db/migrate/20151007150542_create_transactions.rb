class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float :retainers_fee
      t.float :vat
      t.float :percentage
      t.text :transaction_details
      t.belongs_to :client, index: true
      t.timestamps null: false
    end
  end
end

class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :month_and_year
      t.float :retainers_fee
      t.float :vat
      t.float :percentage
      t.string :other_processing
      t.belongs_to :client, index: true
      t.timestamps null: false
    end
  end
end

class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.string :description
      t.string :kind
      t.float :amount
      t.belongs_to :transaction, index: true
      t.timestamps null: false
    end
  end
end

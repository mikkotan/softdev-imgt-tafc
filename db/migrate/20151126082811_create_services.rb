class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.float :monthly_fee
      t.string :service_type

      t.timestamps null: false
    end
  end
end

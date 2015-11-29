class CreateRelatedCosts < ActiveRecord::Migration
  def change
    create_table :related_costs do |t|
      t.string :nature
      t.float :value
      t.belongs_to :service, index: true

      t.timestamps null: false
    end
  end
end

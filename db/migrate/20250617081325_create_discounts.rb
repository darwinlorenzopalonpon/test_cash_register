class CreateDiscounts < ActiveRecord::Migration[8.0]
  def change
    create_table :discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.string :discount_type
      t.integer :discount_value
      t.integer :trigger_quantity

      t.timestamps
    end
  end
end

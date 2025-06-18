class ChangeDiscountValueToDecimal < ActiveRecord::Migration[8.0]
  def up
    change_column :discounts, :discount_value, :decimal, precision: 5, scale: 2
  end

  def down
    change_column :discounts, :discount_value, :integer
  end
end

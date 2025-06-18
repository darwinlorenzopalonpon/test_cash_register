# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  {
    name: "Green Tea",
    price_cents: 311,
    product_code: "GR1",
    discount_type: "buy_one_get_one",
    discount_value: nil,
    trigger_quantity: 2
  },
  {
    name: "Strawberries",
    price_cents: 500,
    product_code: "SR1",
    discount_type: "discount_amount",
    discount_value: 50,
    trigger_quantity: 3
  },
  {
    name: "Coffee",
    price_cents: 1123,
    product_code: "CF1",
    discount_type: "discount_percentage",
    discount_value: 33.33,
    trigger_quantity: 3
  }
].each do |data|
  product_data = {
    name: data[:name],
    price_cents: data[:price_cents],
    product_code: data[:product_code]
  }
  product = Product.find_or_create_by!(product_data)
  Discount.find_or_create_by!(
    product_id: product.id,
    discount_type: data[:discount_type],
    discount_value: data[:discount_value],
    trigger_quantity: data[:trigger_quantity]
  )
end

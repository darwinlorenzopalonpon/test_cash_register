require "test_helper"

class DiscountTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(
      name: "Test Product",
      product_code: "TEST1",
      price_cents: 1000
    )
    @discount = Discount.new(
      product: @product,
      discount_type: "buy_one_get_one",
      discount_value: 0,
      trigger_quantity: 2
    )
  end

  test "should be valid with valid attributes" do
    assert @discount.valid?
  end

  test "should not be valid without a product" do
    @discount.product = nil
    assert_not @discount.valid?
  end

  test "should not be valid without a discount type" do
    @discount.discount_type = nil
    assert_not @discount.valid?
  end

  test "should not be valid with an invalid discount type" do
    @discount.discount_type = "invalid_type"
    assert_not @discount.valid?
  end
end

# test/models/product_test.rb
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(
      name: "Test Product",
      product_code: "TEST1",
      price_cents: 1000
    )
  end

  test "should be valid with valid attributes" do
    assert @product.valid?
  end

  test "should not be valid without a name" do
    @product.name = nil
    assert_not @product.valid?
  end

  test "should not be valid without a product code" do
    @product.product_code = nil
    assert_not @product.valid?
  end

  test "should not be valid without a price" do
    @product.price_cents = nil
    assert_not @product.valid?
  end

  test "should not be valid with a negative price" do
    @product.price_cents = -100
    assert_not @product.valid?
  end

  test "should not be valid with a duplicate product code" do
    @product.save!
    duplicate_product = @product.dup
    assert_not duplicate_product.valid?
  end

  test "should destroy associated discount when product is destroyed" do
    @product.save!
    @product.create_discount!(
      discount_type: "buy_one_get_one",
      discount_value: 0,
      trigger_quantity: 2
    )

    assert_difference "Discount.count", -1 do
      @product.destroy
    end
  end
end

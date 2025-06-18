require "test_helper"

class DiscountServiceTest < ActiveSupport::TestCase
  def setup
    @discount_service = DiscountService.new

    @green_tea = products(:green_tea)
    @strawberries = products(:strawberries)
    @coffee = products(:coffee)
    @no_discount_product = products(:no_discount_product)
  end

  test "should apply buy one get one discount" do
    result = @discount_service.apply_discount(@green_tea, 3)
    expected = 2 * @green_tea.price_cents
    assert_equal expected, result
  end

  test "should apply discount amount" do
    result = @discount_service.apply_discount(@strawberries, 3)
    expected = 3 * @strawberries.price_cents - 150
    assert_equal expected, result
  end

  test "should apply discount percentage" do
    result = @discount_service.apply_discount(@coffee, 3)
    expected = (3 * (@coffee.price_cents - (@coffee.price_cents * 0.3333))).round
    assert_equal expected, result
  end

  test "should not apply discount if no discount is present" do
    result = @discount_service.apply_discount(@no_discount_product, 3)
    expected = 3 * @no_discount_product.price_cents
    assert_equal expected, result
  end
end

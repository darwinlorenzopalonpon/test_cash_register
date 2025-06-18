require "test_helper"

class PricingServiceTest < ActiveSupport::TestCase
  def setup
    @green_tea = products(:green_tea)
    @strawberries = products(:strawberries)
    @coffee = products(:coffee)
    @no_discount_product = products(:no_discount_product)
    @discount_service = DiscountService.new
  end

  test "should calculate total price for one type of product" do
    quantity = 2
    checkout_params = { @no_discount_product.product_code.to_s => quantity }
    result = PricingService.new(checkout_params).calculate_totals
    expected = @no_discount_product.price_cents * quantity
    assert_equal expected, result[:total_price_cents]
  end

  test "should calculate total price for multiple types of products" do
    quantity = 2
    checkout_params = {
      @strawberries.product_code.to_s => quantity,
      @no_discount_product.product_code.to_s => quantity
    }
    result = PricingService.new(checkout_params).calculate_totals
    expected = (@strawberries.price_cents * quantity) +
               (@no_discount_product.price_cents * quantity)
    assert_equal expected, result[:total_price_cents]
  end

  test "should calculate total price for product with discount" do
    quantity = 2
    checkout_params = { @green_tea.product_code.to_s => quantity }
    result = PricingService.new(checkout_params).calculate_totals
    expected = @discount_service.apply_discount(@green_tea, quantity)
    assert_equal expected, result[:total_price_cents]
  end

  test "should calculate total price for multiple products with discounts" do
    quantity = 3
    checkout_params = {
      @green_tea.product_code.to_s => quantity,
      @strawberries.product_code.to_s => quantity,
      @coffee.product_code.to_s => quantity
    }
    result = PricingService.new(checkout_params).calculate_totals
    expected = @discount_service.apply_discount(@green_tea, quantity) +
               @discount_service.apply_discount(@strawberries, quantity) +
               @discount_service.apply_discount(@coffee, quantity)
    assert_equal expected, result[:total_price_cents]
  end
end

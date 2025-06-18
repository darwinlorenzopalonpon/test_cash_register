require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  def setup
    @green_tea = products(:green_tea)
    @strawberries = products(:strawberries)
    @coffee = products(:coffee)
    @no_discount_product = products(:no_discount_product)
  end

  test "should get new" do
    get new_checkout_path
    assert_response :success
    assert_not_nil assigns(:products)
    assert_includes assigns(:products), @green_tea
    assert_includes assigns(:products), @strawberries
    assert_includes assigns(:products), @coffee
  end

  test "should render new template with products form" do
    get new_checkout_path
    assert_response :success
    assert_select "form[action=?][method=?]", checkout_index_path, "post"
    assert_select "input[name=?]", "basket[#{@green_tea.product_code}]"
    assert_select "input[name=?]", "basket[#{@strawberries.product_code}]"
    assert_select "input[name=?]", "basket[#{@coffee.product_code}]"
  end

  test "should create checkout with valid basket" do
    post checkout_index_path, params: { 
      basket: { 
        @green_tea.product_code => "2",
        @strawberries.product_code => "1" 
      } 
    }
    assert_response :success
    assert_not_nil assigns(:result)
    assert_not_empty assigns(:result)[:line_items]
    assert assigns(:result)[:total_price_cents] > 0
  end
end

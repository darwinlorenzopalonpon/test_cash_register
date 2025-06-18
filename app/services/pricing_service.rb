class PricingService
  def initialize(checkout_params)
    @checkout_params = checkout_params
    @items = sanitize_params
    @discount_service = DiscountService.new
  end

  def calculate_totals
    return {} if items.blank?

    load_products

    {
      line_items: line_items,
      total_price_cents: calculate_total_price
    }
  end

  private

  attr_reader :checkout_params, :items, :products, :discount_service

  def sanitize_params
    return {} if checkout_params.blank?

    checkout_params.transform_values(&:to_i)
                   .select { |_, quantity| quantity > 0 }
                   .to_h
  end

  def load_products
    @products = Product.includes(:discount).where(product_code: items.keys)
  end

  def line_items
    items.map do |product_code, quantity|
      product = products.find { |p| p.product_code == product_code }
      line_item(product, quantity)
    end
  end

  def line_item(product, quantity)
    discounted_price = @discount_service.apply_discount(product, quantity)

    {
      product_code: product.product_code,
      quantity: quantity,
      price: product.formatted_price,
      total: discounted_price
    }
  end

  def calculate_total_price
    line_items.sum { |item| item[:total] }
  end
end

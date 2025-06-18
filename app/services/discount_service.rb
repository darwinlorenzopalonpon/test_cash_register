class DiscountService
  def apply_discount(product, quantity)
    discount = product.discount

    return default_price(product, quantity) unless discount.present?

    if quantity >= discount.trigger_quantity
      calculate_discounted_price(product, quantity)
    else
      default_price(product, quantity)
    end
  end

  private

  def calculate_discounted_price(product, quantity)
    case product.discount.discount_type
    when "buy_one_get_one"
      apply_buy_one_get_one(product, quantity)
    when "discount_amount"
      apply_discount_amount(product, quantity)
    when "discount_percentage"
      apply_discount_percentage(product, quantity)
    end
  end

  def apply_buy_one_get_one(product, quantity)
    trigger_qty = product.discount.trigger_quantity
    paid_items = quantity / trigger_qty
    remainder = quantity % trigger_qty
    paid_quantity = (paid_items * (trigger_qty - 1)) + remainder
    paid_quantity * product.price_cents
  end

  def apply_discount_amount(product, quantity)
    discounted_price = product.price_cents - product.discount.discount_value
    discounted_price * quantity
  end

  def apply_discount_percentage(product, quantity)
    discounted_price = product.price_cents - (product.price_cents * (product.discount.discount_value.to_f / 100.0))
    (discounted_price * quantity).round
  end

  def default_price(product, quantity)
    product.price_cents * quantity
  end
end

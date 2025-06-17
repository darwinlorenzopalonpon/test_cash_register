# frozen_string_literal: true

class Discount < ApplicationRecord
  belongs_to :product

  DISCOUNT_TYPES = {
    buy_one_get_one: 'buy_one_get_one',
    discount_amount: 'discount_amount',
    discount_percentage: 'discount_percentage'
  }

  validates :discount_type, presence: true, inclusion: { in: DISCOUNT_TYPES.values }
  validates :trigger_quantity, presence: true, numericality: { greater_than: 0 }
end

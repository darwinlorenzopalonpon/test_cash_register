class Product < ApplicationRecord
  validates :name, presence: true
  validates :price_cents, presence: true, numericality: { greater_than: 0 }
  validates :product_code, presence: true, uniqueness: true

  has_one :discount, dependent: :destroy

  def price_in_euros
    price_cents / 100.0
  end

  def formatted_price
    "€ #{price_in_euros.round(2)}"
  end
end

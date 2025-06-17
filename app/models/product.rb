class Product < ApplicationRecord
  validates :name, presence: true
  validates :price_cents, presence: true, numericality: { greater_than: 0 }
  validates :product_code, presence: true, uniqueness: true

  has_one :discount, dependent: :destroy
end

class Order < ApplicationRecord
  belongs_to :customer

  validates :product_name, presence: true
  validates :product_count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :customer, presence: true
end

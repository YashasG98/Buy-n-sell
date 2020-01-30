class Order < ApplicationRecord
  validates :user_id, {presence: true}
  validates :product_id, {presence: true}
end

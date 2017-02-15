class Category < ApplicationRecord
  has_many :suggest_products, dependent: :destroy
  has_many :products, dependent: :destroy
end

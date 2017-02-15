class Product < ApplicationRecord
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy
end

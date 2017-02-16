class Product < ApplicationRecord
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy

  def self.get_hot item
    @result = Product.select{|x| x.is_hot && x.id==item.id }.shuffle.first
  end

  def self.get_relate item
    @result = Product.select{|x| x.id==item.id }.shuffle.take(3)
  end

  def self.get_random
    @result = Product.order("RANDOM()").first
  end
end

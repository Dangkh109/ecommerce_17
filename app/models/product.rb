class Product < ApplicationRecord
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_attached_file :image, styles: {small: Settings.small,
    med: Settings.medium, large: Settings.large}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.take_hot item
    @result = Product.select{|product|
      product.is_hot && product.category_id == item.category_id}.shuffle.first
  end

  def self.take_relate item
    @result = Product.select{|product| product.category_id == item.category_id}
      .shuffle.take Settings.Product_take_rand
  end

  def self.take_random
    @result = Product.order("RANDOM()").take Settings.Product_take_rand
  end

  def self.get_product_by_category id, category
    @result = category.products.find_by id: id
  end

  def self.search search
    if search
      where("name LIKE ?", "%#{search}%")
    else
      all
    end
  end
end

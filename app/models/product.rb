class Product < ApplicationRecord
  belongs_to :category
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_attached_file :image, styles: {small: Settings.small,
    med: Settings.medium, large: Settings.large}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  class << self
    def take_hot_product item
      @result = Product.select{|product|
        product.is_hot && product.category_id == item.category_id}.shuffle.first
    end

    def take_relate_product item
      @result = Product.select{|product| product.category_id == item.category_id}
        .shuffle.take Settings.product.take_rand
    end

    def take_random_product
      @result = Product.order("RANDOM()").take Settings.product.take_rand
    end

    def get_product_by_category id, category
      @result = category.products.find_by id: id
    end

    def take_home_product
      @result = Product.select{|product|
      product.is_hot}.shuffle.take Settings.product.take_home
    end

    def search search, category_id
      search ? where("name LIKE '%#{search}%' AND category_id = #{category_id}") : all
    end
  end
end

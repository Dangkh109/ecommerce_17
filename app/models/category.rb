class Category < ApplicationRecord
  has_many :suggest_products, dependent: :destroy
  has_many :products, dependent: :destroy

  def self.get_cate_child parent_code
    return result = Category.where(
      "code LIKE '%#{parent_code}%'").includes(:products)
  end
end

class Category < ApplicationRecord
  has_many :suggest_products, dependent: :destroy
  has_many :products, dependent: :destroy

  def self.get_cate_child dad_code
    return result = Category.where("code LIKE '%#{dad_code}%'")
  end
end

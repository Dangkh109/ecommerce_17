class Category < ApplicationRecord
  has_many :suggest_products, dependent: :destroy
  has_many :products, dependent: :destroy
  validates :name, presence: true, uniqueness: true, allow_blank: false

  def self.get_cate_child parent_code
    result = Category.where(
      "code LIKE '%#{parent_code}%'").includes(:products)
    result = result.reject{|category| category.code == parent_code}
  end

  def self.get_child parent_id
    return where(parent_id: parent_id)
  end
end

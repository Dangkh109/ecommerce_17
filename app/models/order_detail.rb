class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def check_product_quantity
    return quantity > product.in_stock ? true : false
  end

  def update_product_quantity
    product.update in_stock: product.in_stock - quantity
    product.update sold_quantity: product.sold_quantity + quantity
  end
end

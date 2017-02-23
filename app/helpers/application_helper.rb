module ApplicationHelper
  def picture_for product
    if product.image?
      image_tag product.image, class: "image-product-side"
    else
      image_tag "missing.jpg", class: "image-product-side"
    end
  end

  def index_for counter, page, limit
    (page - 1) * limit + counter + 1
  end

  def validate_product product_id
    return @product.in_stock.present? && @product.in_stock > 0 && session[@product.id].nil? ? true : false
  end
end

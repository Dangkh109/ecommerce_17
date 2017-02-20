module ApplicationHelper
  def picture_for product
    if product.image?
      image_tag product.image, class: "image-product-side"
    else
      image_tag "missing.jpg", class: "image-product-side"
    end
  end
end

module ApplicationHelper
  def picture_for product
    if product.image?
      image_tag product.image, class: "image-product-side"
    else
      image_tag "missing.jpg", class: "image-product-side"
    end
  end

  def sortable column
    if column == sort_column && sort_direction == "asc"
      direction = "desc"
    else
      direction = "asc"
    end
    link_to column, {sort: column, direction: direction}
  end
end

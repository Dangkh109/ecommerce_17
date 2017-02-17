class CategoryController < ApplicationController
  def index
    @products = Product.order("RANDOM()").take(Settings.Product_take_random)
    @categories = Category.select{|x| x.parent_id == Settings.Parent_id}
  end
end

class StaticPagesController < ApplicationController
  def home
    @products = Product.select{|product|
      product.is_hot}.shuffle.take(Settings.Product_take_home)
  end

  def about
  end
end

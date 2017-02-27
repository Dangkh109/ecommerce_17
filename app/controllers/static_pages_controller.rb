class StaticPagesController < ApplicationController
  def home
    @products = Product.take_home_product
  end

  def about
  end
end

class StaticPagesController < ApplicationController
  def home
    @products = Array.new
    @products.push Product.select{|prod|
      prod.is_hot}.shuffle.take(Settings.Product_take_home)
    @products.push Product.order("RANDOM()").take(Settings.Product_take_home)
  end

  def about
  end
end

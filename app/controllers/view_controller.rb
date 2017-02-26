class ViewController < ApplicationController
  def index
    @products = Product.load_product_by_id " ", session[:viewed]
  end
end

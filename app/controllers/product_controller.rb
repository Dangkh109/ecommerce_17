class ProductController < ApplicationController
  def show
    @product = Product.find_by id: params[:id]
    if @product.nil?
      flash[:danger] = t :not_exist_data
      redirect_to home_path
    else
      @relate = Product.get_relate @product
      @hot = Product.get_hot @product
      @randomize = Product.get_random
    end
  end
end

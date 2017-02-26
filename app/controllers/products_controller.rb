class ProductsController < ApplicationController
  before_action :load_category, only: [:index, :show]

  def index
    @products = Product.select{|prod|
      prod.category_id == @category.id}.take Settings.Product_showed_number
    @products = Kaminari.paginate_array(@products)
    .page(params[:page]).per Settings.Product_per_page
  end

  def show
    @product = Product.get_product_by_category params[:id], @category
    if @product.nil?
      flash[:danger] = t :not_exist_data
      redirect_to home_path
    else
      @supports = Supports::Product.new @product
      if session[:viewed].present?
        session[:viewed] = session[:viewed].append(@product.id)
      else
        session[:viewed]= [@product.id]
      end
    end
  end
end

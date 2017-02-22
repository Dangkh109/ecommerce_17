class ProductsController < ApplicationController
  before_action :load_category, only: [:index, :show]
  helper_method :sort_column, :sort_direction

  def index
    @products = Product.search(
      params[:search]).order(sort_column + " " + sort_direction)
    @products = @products.select{|product|
      product.category_id == @category.id}.take Settings.Product_showed_number
    @products = Kaminari.paginate_array @products
    .page(params[:page]).per Settings.Product_per_page
  end

  def show
    @product = Product.get_product_by_category params[:id], @category
    if @product.nil?
      flash[:danger] = t :not_exist_data
      redirect_to home_path
    else
      @supports = Supports::Product.new @product
    end
  end

  private
  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    ["asc", "desc"].include?(params[:direction]) ? params[:direction] : "asc"
  end
end

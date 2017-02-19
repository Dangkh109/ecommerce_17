class ProductController < ApplicationController
  before_action :load_category
  def index
    @list = Product.select{
      |x| x.category_id = @category.id}.take Settings.Product_showed_number
    @products = @list.paginate(page: params[:page],
      per_page: Settings.product_per_page)
  end

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
    if @category.nil?
      flash[:danger] = t :not_exist_data
      redirect_to home_path
    end
  end
end

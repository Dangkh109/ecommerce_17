class CategoryController < ApplicationController
  before_action :load_category, only: [:show]

  def index
    @products = Product.order("RANDOM()").take Settings.product.take_rand
    @categories = Category.select{|cate| cate.parent_id == Settings.Parent_id}
  end

  def show
    @categories = Category.get_cate_child @category.code
  end

  private
  def load_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t :not_exist_data
      redirect_to home_path
    end
  end
end

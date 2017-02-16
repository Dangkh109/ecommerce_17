class CategoryController < ApplicationController
  before_action :load_category, only: [:show]
  def index
    @products = Product.order("RANDOM()").take(5)
    @categories = Category.select{|x| x.parent_id == params[:category_id].to_i}
  end

  def show
    @products = Array.new
    list = Category.get_cate_child @category.code
    list.each do |cate|
      @products << Product.includes(:category).select{|x| x.category_id == cate.id}
    end
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

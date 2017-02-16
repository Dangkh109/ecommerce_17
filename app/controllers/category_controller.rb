class CategoryController < ApplicationController
  def index
    @products = Product.order("RANDOM()").take(5)
    @categories = Category.select{|x| x.parent_id == params[:category_id].to_i}
  end

  def show
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t :not_exist_data
      redirect_to home_path
    else
      list = prepare
      @products = Array.new
      list.each do |id|
        @products << Product.select{|x| x.category_id == id}
      end
    end
  end

  private
  def prepare
    parent_id = params[:id].to_i
    number_cate = Category.all.count
    a = Array.new(number_cate+1, 0)
    b = Array.new(number_cate+1, 0)
    a[0] = -1
    b[0] = -1
    (1..number_cate).each do |i|
      tmp = Array.new
      value = 0
      x = i
      while a[x]==0 do
        cate = Category.find_by id: x
        if cate.parent_id == parent_id || a[cate.parent_id] == parent_id
          a[x] = parent_id
          value = parent_id
          break
        else
          tmp << x
        end
        x = cate.parent_id
        b[x] = -1
        tmp.each do |x|
          a[x] = value
        end
      end
    end
    result = Array.new
    (1..number_cate).each do |i|
      result << i if a[i]==parent_id && b[i]==0
    end
    result.append(parent_id) if result.count==0
    result
  end
end

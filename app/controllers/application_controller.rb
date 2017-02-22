class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_random

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
    if @category.nil?
      flash[:danger] = t :not_exist_data
      redirect_to home_path
    end
  end

  def load_random
    @randomize = Product.take_random
  end
end

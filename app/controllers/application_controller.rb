class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_random_product

  rescue_from CanCan::AccessDenied do
    redirect_to root_path
  end

  def verify_admin
    unless current_user.present? and current_user.admin?
      redirect_to root_path
    end
  end

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
    if @category.nil?
      flash[:danger] = t :not_exist_data
      redirect_to home_path
    end
  end

  def load_random_product
    @randomize = Product.take_random_product
  end
end

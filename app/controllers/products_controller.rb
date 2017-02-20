class ProductsController < ApplicationController
  before_action :load_category, only: [:index]

  def index
    @products = Product.select{|prod|
      prod.category_id == @category.id}.take Settings.Product_showed_number
    @products = Kaminari.paginate_array(@products)
    .page(params[:page]).per Settings.Product_per_page
  end
end

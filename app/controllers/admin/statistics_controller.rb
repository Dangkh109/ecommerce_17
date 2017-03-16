class Admin::StatisticsController < ApplicationController
  before_action :verify_admin, :authenticate_user!

  def index
    month_start = Time.new Time.now.year, Time.now.mon
    orders = OrderDetail.load_orders_by_month month_start
    @products = Product.load_product_by_order orders
    respond_to do |format|
      format.html
      format.xls
    end
    @data = Array.new
    @products.each do |product, quantity|
      @data.append [product.name, quantity]
    end
    @products = Kaminari.paginate_array(@products).page(params[:page])
      .per Settings.product.per_page
  end
end

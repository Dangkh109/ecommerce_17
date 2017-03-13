class Admin::StatisticsController < ApplicationController
  before_action :verify_admin, :authenticate_user!

  def index
    month_start = Time.new Time.now.year, Time.now.mon
    orders = OrderDetail.load_orders_by_month month_start
    @products = Array.new
    orders.each do |order_detail|
      if @products.present? && order_detail.id == @products.last.first.id
        @products.last.second += order_detail.quantity
      else
        @products.append [Product.find_by(id: order_detail.id), order_detail.quantity]
      end
    end
    @products = Kaminari.paginate_array(@products).page(params[:page])
      .per Settings.product.per_page
    @line = Order.group_by_hour(:created_at).count
  end
end

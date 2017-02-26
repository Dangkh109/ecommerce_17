class Users::OrdersController < ApplicationController
  def create
    if current_user.present? && !current_user.admin?
      @products = Product.load_product_by_id " ", session[:cart]
      price = 0
      @products.each do |product|
        price += product.price * session[product.id].to_i
      end
      order = current_user.orders.create total_price: price, status: Settings.order.new
      @products.each do |product|
        order.order_details.create quantity: session[product.id], product_id: product.id
      end
      session[:cart].each do |id|
         session[id] = nil
       end
      session[:cart] = nil
      flash[:success] = "order successfully"
      redirect_to root_path
    else
      flash[:error] = "login_please_as_user"
      redirect_to root_path
    end
  end
end

class SessionsController < ApplicationController

  def index
    @products = Product.load_product_by_id params[:search], session[:cart]
    @product_quantity = Array.new
    @products.each do |product|
      @product_quantity.append [product, session[product.id]]
    end
  end

  def create
    @product = Product.find_by id: session_params[:product_id]
    session[:total_price] = 0 if session[:total_price].nil?
    if @product.present?
      quantity = session_params[:quantity].to_i
      if quantity > 0 && quantity <= @product.in_stock
        if session[:cart].present?
          session[:cart] = session[:cart].append session_params[:product_id]
        else
          session[:cart] = [session_params[:product_id]]
        end
        session[session_params[:product_id]] = session_params[:quantity]
        session[:total_price] += @product.price * quantity
        redirect_to :back
      else
        flash[:warning] = t :product_invalid_quantity
        redirect_to :back
      end
    else
      flash[:warning] = t :invalid_product
      redirect_to root_path
    end
  end

  def update
    @product = Product.find_by id: session_params[:product_id]
    session[:total_price] += (session_params[:quantity] - session[@product.id]) *
      @product.price
    session[session_params[:product_id]] = session_params[:quantity]
    redirect_to :back
  end

  def destroy
    session[:cart].reject!{|id| id == params[:id]}
    session[params[:id]] = nil
    redirect_to :back
  end

  private

  def session_params
    params.require(:sessions).permit :product_id, :quantity, :category_id
  end
end

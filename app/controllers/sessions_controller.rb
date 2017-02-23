class SessionsController < ApplicationController

  def index
    @products = Product.load_product_by_id params[:search], session[:cart]
    @product_quantity = Array.new
    @products.each do |product|
      @product_quantity.append([product, session[product.id]])
    end
  end

  def create
    if session[:cart].present?
      session[:cart] = session[:cart].append(session_params[:product_id])
    else
      session[:cart]= [session_params[:product_id]]
    end
    session[session_params[:product_id]] = session_params[:quantity]
    redirect_to category_product_path(category_id: session_params[:category_id],
      id: session_params[:product_id])
  end

  def destroy
    if params[:sessions].present? && params[:sessions].include?(:delete_all)
      session[:cart].each do |id|
         session[id] = nil
       end
       session[:cart] = nil
    else
      session[:cart].reject!{|id| id == params[:id]}
      session[params[:id]] = nil
    end
    redirect_to :back
  end

  private

  def session_params
    params.require(:sessions).permit :product_id, :quantity, :category_id
  end
end

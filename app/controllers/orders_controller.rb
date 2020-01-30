class OrdersController < ApplicationController

  #to authenticate user before restricted access
  before_action :authenticate_user

  #to create an order (to buy a product)
  #request: POST
  def new
    prod_id = params[:id]
    product = Product.find_by(id: prod_id)
    if product.cost <= @current_user.wallet
      flash[:notice] = "Bought product successfully!"
      @current_user.wallet -= product.cost
      @current_user.save
      prod_owner = User.find_by(id: product.user_id)
      prod_owner.wallet += product.cost
      prod_owner.save
      order = Order.new(user_id:@current_user.id,product_id:prod_id)
      order.save
      redirect_to("/users/dashboard")
    else
      @products = Product.where.not(user_id: @current_user.id)
      flash.now.alert = "Not enough balance"
      render("products/list")
    end
  end

  #get order history of the logged in user
  #request: GET
  def list
    @orders = Order.where(user_id: @current_user.id)
  end
end

class ProductsController < ApplicationController
  
  #to authenticate user before restricted access
  before_action :authenticate_user

  #to initialize a product to be added by the user
  #request: GET
  def add
    @product = Product.new
  end

  #to allow the user to add a product to sell
  #request: POST
  def create
    @product = Product.new
    @product.name = params[:name]
    @product.description = params[:description]
    @product.age = params[:age]
    @product.cost = params[:cost]
    @product.user_id = @current_user.id

    if params[:image]
      @product.image = "#{@current_user.id}_#{@current_user.number_of_products}.jpg"
      image = params[:image]
      File.binwrite("public/assets/product_images/#{@product.image}", image.read)
    end

    if @product.save
      flash[:notice] = 'Product added successfully!'
      @current_user.number_of_products += 1
      @current_user.save
      redirect_to("/users/dashboard")
    else
      @name = params[:name]
      @description = params[:description]
      @age = params[:age]
      @cost = params[:cost]
      @image = params[:image]
      render("products/add")
    end
  end

  #to get the items available for buying for the user
  #request: GET
  def list
    @products = Product.where.not(user_id: @current_user.id)
  end

  #to get the list of items sold by the user
  #request: GET
  def self_products
    @products = Product.where(user_id: @current_user.id)
  end

end

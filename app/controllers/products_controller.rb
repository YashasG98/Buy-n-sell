class ProductsController < ApplicationController
  
  before_action :authenticate_user

  def add
    @product = Product.new
  end

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

  def list
    @products = Product.where.not(user_id: @current_user.id)
  end

  def self_products
    @products = Product.where(user_id: @current_user.id)
  end
  
end

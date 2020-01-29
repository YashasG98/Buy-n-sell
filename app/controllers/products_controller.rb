class ProductsController < ApplicationController
  
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
      File.binwrite("storage/product_images/#{@product.image}", image.read)
    end

    if @product.save
      @current_user.number_of_products += 1
      @current_user.save
      redirect_to("/users/#{@current_user.id}/dashboard")
    else
      render("products/add")
    end
  end

end

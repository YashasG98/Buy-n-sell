class UsersController < ApplicationController

  #to authenticate user before restricted access
  before_action :authenticate_user, {only:[:dashboard,:credit_form,:credit]}
  before_action :check_admin, {only:[:credit,:credit_form]}

  #to declare a user object for user about to sign up
  #request: GET
  def new
    @user = User.new
  end

  #to reqister a new user
  #request: POST
  def create
    @user = User.new(
      name: params[:name],
      contact: params[:contact],
      address: params[:address],
      password: params[:password],
      number_of_products: 0
    )
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/users/dashboard")
    else
      render("/users/new")
    end
  end

  #to display the user dashboard
  def dashboard
  end

  #to validate and upon success, login the user
  #request: POST
  def login
    @user = User.find_by(contact: params[:contact])
    if @user && @user.authenticate(params[:password])
      flash[:notice] = 'Logged in successfully!'
      session[:user_id] = @user.id
      redirect_to("/users/dashboard")
    else
      flash[:alert] = "Invalid contact number/password combination"
      @contact = params[:contact]
      @password = params[:password]
      render("/users/login_form")
    end
  end

  #to display login_form
  #request: GET
  def login_form
  end

  #to logout currently logged in user
  #request: POST
  def logout
    session[:user_id] = nil
    flash[:notice] = "You have logged out successfully"
    redirect_to("/")
  end

  #to display credit_form for admins
  #request : GET
  def credit_form
  end

  #to validate entered details and to credit the user
  #request : POST
  def credit
    @user = User.find_by(contact: params[:contact])
    @contact = params[:contact]
    @amount = params[:amount]
    if @user == nil
      flash[:alert] = "No user found for given phone number"
      render("/users/credit_form")
    elsif @amount.to_i.to_s == '0'
      flash[:alert] = "Enter proper value for amount to be credited"
      render("/users/credit_form")
    else
      @user.wallet += @amount.to_i
      @user.save
      flash[:notice] = "Amount credited successfully"
      redirect_to("/users/dashboard")
    end
  end

  #to check if the user logged in is an admin
  def check_admin
    if @current_user.admin == false
      flash[:alert] = "This feature is only available for admins"
      redirect_to("/users/dashboard")
    end
  end

end

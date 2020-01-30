Rails.application.routes.draw do
  
  get   "orders/list" => "orders#list"
  post  "orders/:id/create" => "orders#new"
  
  get   "products/self"  => "products#self_products"
  post  "products/create" => "products#create"
  get   "products/add" => "products#add"
  get   "products/shop" => "products#list"

  post  "logout" => "users#logout"
  post  "login" => "users#login"
  get   "signup" => "users#new"
  get   "login" => "users#login_form"
  post  "users/create" => "users#create"
  get   "users/dashboard" => "users#dashboard"

  get "/" => "home#top"
  
end

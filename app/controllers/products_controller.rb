class ProductsController < ApplicationController
  @@user_id = nil

  #def initialize #pourquoi il change ma vue quand je met cette methode
  #end

  def index
    @stock = []
    @rupture = []
    @products = Product.all
    if logged_in?
      @@user_id = current_user.id
      @user_products = []
      @products.each do |x| #mémo => la méthode ActiveRecord find_by ne renvoie que la 1ère valeur. Existe t'il la même méthode qui renvoie toutes les valeurs
        if x.user_id == current_user.id
          @user_products << x
        end
      end
      @products = @user_products
    end
    @products.each do |x| 
      if x.amount <= 0 
       then @rupture << x
     else @stock << x 
     end
   end
 end

 def new
  if @@user_id != nil 
  #@variable = user.products.create
  @variable = Product.new
  @variable.name = params[:input]
  @variable.amount = 1
  @variable.user_id = @@user_id
  @variable.save
  redirect_to root_path
else
 @variable = Product.new
 @variable.name = params[:input]
 @variable.amount = 1
 @variable.save
 redirect_to root_path
end
end

def delete
 Product.find(params[:id]).destroy
 redirect_to root_path
end

def add
 @variable = Product.find(params[:id])
 @variable.amount += 1
 @variable.save
 redirect_to root_path
end

def remove
 @variable = Product.find(params[:id])
 @variable.amount -= 1
 if @variable.amount < 0
  then @variable.amount = 0
end
@variable.save
redirect_to root_path
end

def purchase
  @variable = Product.find(params[:id])
  new_amount = params[:input] 
  @variable.amount += new_amount.to_i
  @variable.save
  redirect_to root_path
end
end
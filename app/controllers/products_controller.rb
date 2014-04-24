class ProductsController < ApplicationController
  def index
  	@product = Product.random_product(current_user.id)

  	@primary_image = Product::Image.where(product_id: @product.id, is_primary: true).first

  	@secondary_images = Product::Image.where(product_id: @product.id, is_primary: false)

  end

  def show
  	@product = Product.find(params[:id])

  	@primary_image = Product::Image.where(product_id: @product.id, is_primary: true).first

  	@secondary_images = Product::Image.where(product_id: @product.id, is_primary: false)
  end
end

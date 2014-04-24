class UserProductPreferencesController < ApplicationController
  
  # before_filter :user_authenticate
  respond_to :json, :html
  require 'csv'
  
  def create
    @preference = UserProductPreference.where(user_id: current_user.id, product_id: pref_params[:product_id]).first || UserProductPreference.new(pref_params)
    @preference.user_id = current_user.id
    if @preference.save
      @product = Product.random_product(current_user.id)
      respond_with @product, status: :created
    else
      flash[:notice] = "Whoops"
      redirect_to products_path
    end
  end

  def update
    @preference = UserProductPreference.find(params[:id])
    @preference.update_attributes!(pref_params)
    respond_with @preference, status: :ok
  end

  private
  def pref_params
    params.require(:user_product_preference).permit(:product_id, :preference, :is_racked)
  end

end

# What happens when a user changes his/her mind on a product

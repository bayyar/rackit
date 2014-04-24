class Users::FeedsController < ApplicationController

def index
	@user = User.where(username: params[:username]).first
	# Need to fix this
	@preferences = UserProductPreference.all.where(is_racked: true).limit(27)
	# Alternative that is closer to the eventual one.
	# @preferences = Product.joins(:user_product_preferences).where({ user_product_preferences: { is_racked: true }})
	@following = @user.following
  @followers = User.followers(@user)
end

end

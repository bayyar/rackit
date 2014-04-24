class Users::FeedsController < ApplicationController

def index
	@user = User.where(username: params[:username]).first
	# Need to fix this
	@preferences = UserProductPreference.all.where(is_racked: true).limit(27)
	@following = @user.following
  @followers = User.followers(@user)
end

end

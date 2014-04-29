class Users::FeedsController < ApplicationController

def index
	@user = User.where(username: params[:username]).first
	# Need to fix this
	@preferences = UserProductPreference.feed(@user)
	@following = @user.following
  @followers = User.followers(@user)
end

end

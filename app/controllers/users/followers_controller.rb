class Users::FollowersController < ApplicationController

def index
	@user = User.where(username: params[:username]).first
	@following = @user.following
  @followers = User.followers(@user)
end

end

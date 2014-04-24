class UsersController < ApplicationController
  def index
  	@users = User.all_except(current_user)
  end

  def show
  	@user = User.where(username: params[:username]).first
  	# @preferences = UserProductPreference.where(user_id: @user.id, is_racked: true).order(created_at: :desc)
  	@preferences = UserProductPreference.rack(@user)
  	@following = @user.following
  	@followers = User.followers(@user)
  end
end

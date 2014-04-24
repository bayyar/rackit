class UserFriendshipsController < ApplicationController

# before_filter :authenticate_user!
respond_to :json, :html

def create

	@friendship = current_user.user_friendships.where(friend_id: friend_params[:friend_id]).first ||
		UserFriendship.new(friend_params)
	@friendship.user_id = current_user.id
	@friendship.save

	respond_with @friendship, status: :created

end

def index
	@users = User.all_except(current_user)
end

def destroy
	if resource
		resource.destroy
	end
	respond_with @user, status: :accepted
end

private
def friend_params
  params.require(:user_friendships).permit(:friend_id)
end

def resource
  @resource ||= current_user.user_friendships.where(:id => params[:id]).first
end

end

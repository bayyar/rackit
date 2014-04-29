class UserProductPreference < ActiveRecord::Base

	belongs_to :user
	belongs_to :product


	def self.rack(user)
		UserProductPreference.where({ user_product_preferences: { is_racked: true, user_id: user.id }})
	end

	def self.feed(user)
		UserProductPreference.where({ user_product_preferences: { is_racked: true }}).limit(33)
		# u = user.user_friendships.each do |friend|
		# 	UserProductPreference.where({ user_product_preferences: { is_racked: true, user_id: friend.friend_id }})
		# end
	end

	def self.global
		# How to order by "racks.count"?
		UserProductPreference.where({ user_product_preferences: { is_racked: true }}).limit(33)
	end


end

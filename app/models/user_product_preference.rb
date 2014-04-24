class UserProductPreference < ActiveRecord::Base

	belongs_to :user
	belongs_to :product


def self.rack(user)
	UserProductPreference.where(user_id: user.id, is_racked: true).order(created_at: :desc)
end

def self.feed(user)
end

end

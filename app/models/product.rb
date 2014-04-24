class Product < ActiveRecord::Base

	belongs_to :brand
	has_many :product_images, class_name: "Product::Image", dependent: :destroy
	has_many :user_product_preferences, class_name: "UserProductPreference", foreign_key: "product_id", dependent: :destroy

	def racks
		user_product_preferences.where(is_racked: true).count
	end

	def self.random_product(user_id)
		where("products.id NOT IN (SELECT user_product_preferences.product_id from user_product_preferences where user_product_preferences.user_id = ?)", user_id).order('random()').limit(1).first
	end

end

class AddIsRackedToUserProductPreferencesTable < ActiveRecord::Migration
  def change
  	add_column :user_product_preferences, :is_racked, :boolean, default: false
  end
end

json.user do |json|
	json.racked_products current_user.racked_products.count
end
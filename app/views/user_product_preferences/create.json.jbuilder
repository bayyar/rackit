json.product do |json|
	json.id @product.id
	json.name @product.name
	json.price number_to_currency(@product.price.to_f / 100)
	json.brand @product.brand
	json.primary_image @product.product_images.first
	json.secondary_images @product.product_images.where(is_primary: false)
	json.description @product.description
end
json.user do |json|
	json.racked_products current_user.racked_products.count
end
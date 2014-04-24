$(document).ready ->
	
	$('.upp_unrack').click (event) ->
		preference_id = $(this).attr("data-preference-id")
		$.ajax
			url: "/user_product_preferences/#{ preference_id }"
			dataType: "json"
			type: "PUT"
			data:
				user_product_preference:
					is_racked: false
			success: (data) ->
				$(".product_preference_#{ preference_id }").detach()
				console.log(data)
				return
		return
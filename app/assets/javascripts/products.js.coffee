$(document).ready ->
		
	# Checks which thumbnail matches primary image and adds opacity
	image_id = $(".primary_image_container").data("primary-image-id")
	$('div[data-image-id="' + image_id + '"]').addClass('thumb_opacity')

	# Makes the clicked thumb the primary image, and adds opacity to the active thumb
	$(".thumb").click (event) ->
		thumbClickHandler($(this))
		return

	$(".dislike").click (event) ->
	  product_id = $(this).attr("data-product-id")
	  $.ajax
	    url: "/user_product_preferences"
	    dataType: "json"
	    type: "POST"
	    data:
	      user_product_preference:
	        product_id: product_id
	        is_racked: false
	    success: (data) ->
	    	console.log(data)
	    	updateProductView(data.product, data.user)
      return
	  return

	$(".like").click (event) ->
	  product_id = $(this).attr("data-product-id")
	  $.ajax
	    url: "/user_product_preferences"
	    dataType: "json"
	    type: "POST"
	    data:
	      user_product_preference:
	        product_id: product_id
	        is_racked: false
	        preference: true
	    success: (data) ->
	    	console.log(data)
	    	updateProductView(data.product, data.user)
      return

	  return

	$('.rackit').click (event) ->
		product_id = $(this).attr("data-product-id")
		$.ajax
	    url: "/user_product_preferences"
	    dataType: "json"
	    type: "POST"
	    data:
	      user_product_preference:
	        product_id: product_id
	        is_racked: true
	        preference: true
	    success: (data) ->
	    	console.log(data)
	    	updateProductView(data.product, data.user)
      return
	  return

	thumbClickHandler = (target) ->
		# console.log(target)
		# Removes opacity from all thumbnail images
		$(".thumb").removeClass('thumb_opacity')
		# Identifies product and image ID of the clicked thumb
		product_id = target.data("product-id")
		image_id = target.data("image-id")
		# console.log(product_id + "THIS IS THE PRODUCT ID")
		# console.log(image_id + "THIS IS THE IMAGE ID")
		# Changes primary image to image that matches clicked thumb
		$("#primary_image").attr('src', 'https://shoprackit.s3.amazonaws.com/uploads/products/p-'+product_id+'/i-'+image_id+'/image.jpg')
		# Changes data attribute on container to the image id
		$(".primary_image_container").attr('data-primary-image-id', image_id)
		# Adds opacity to the active thumb
		target.addClass('thumb_opacity')
	return

updateProductView = (product, user) ->
	# Change all product description attributes
	$('#product_name').html(product.name)
	$('#product_price').html('(' + product.price + ')')
	$('#product_brand').html(product.brand.name)
	$('#product_description').html(product.description)
	$('#product_buy_url>a').attr('href', product.buy_url)
	# Change preference button (Like, Dislike, Rackit) data attributes
	$('.rackit').attr('data-product-id', product.id)
	$('.dislike').attr('data-product-id', product.id)
	$('.like').attr('data-product-id', product.id)
	# Change image and data attributes for primary image and its container
	$('#primary_image').attr('src', product.primary_image.image.url)
	$('.primary_image_container').attr('data-primary-image-id', product.primary_image.id)
	# Changes image and data attributes for primary image thumb and its container
	$('.thumb').removeClass('thumb_opacity')
	$('.primary_thumb_container').detach()
	$('.primary_thumb_super_container').append('<div class="row thumb primary_thumb_container thumb_opacity" data-product-id="' + product.id + '" data-image-id="' + product.primary_image.id + '"><img alt="Thumb image" class="img-responsive" id="primary_image_thumb" src="' +  product.primary_image.image.thumb.url + '"></div>')
	# Detaches thumbnails of non-primary images, and then loops through array of secondary images to produce new thumbnails (if they exist)
	$('.secondary_thumb_container').detach()
	$ ->
		secondaryImages = product.secondary_images
		$.each secondaryImages, ->
			$('.secondary_thumb_super_container').append('<div class="row thumb secondary_thumb_container" data-product-id="' + @product_id + '" data-image-id="' + @id + '"><img alt="Thumb image" class="img-responsive" src="' +  @image.thumb.url + '"></div>')
			console.log "Thumb URL: " + @image.thumb.url
			return
		return
	$(".thumb").on "click", ->
		thumbClickHandler($(this))
		return
	thumbClickHandler = (target) ->
		console.log(target)
		# Removes opacity from all thumbnail images
		$(".thumb").removeClass('thumb_opacity')
		# Identifies product and image ID of the clicked thumb
		product_id = target.data("product-id")
		image_id = target.data("image-id")
		console.log(product_id + "THIS IS THE PRODUCT ID")
		console.log(image_id + "THIS IS THE IMAGE ID")
		# Changes primary image to image that matches clicked thumb
		$("#primary_image").attr('src', 'https://shoprackit.s3.amazonaws.com/uploads/products/p-'+product_id+'/i-'+image_id+'/image.jpg')
		# Changes data attribute on container to the image id
		$(".primary_image_container").attr('data-primary-image-id', image_id)
		# Adds opacity to the active thumb
		target.addClass('thumb_opacity')
	return
return
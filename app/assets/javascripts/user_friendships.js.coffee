$(document).ready ->

# Create a follow/friendship relationship, change the button class to match that of a user being followed, and add data-friendship-id attribute
	$('.follow').click (event) ->
		friend_id = $(this).data("friend-id")
		$.ajax
			url: "/user_friendships"
			dataType: "json"
			type: "POST"
			data:
				user_friendships:
					friend_id: friend_id
			success: (data) ->
				console.log(data)
				# Append a data-friendship-id attribute based on friendship just created
				$('div[data-friend-id="' + friend_id + '"]').attr('data-friendship-id', data.friendship.id)
				# Change button content and class to indicate new relationship
				$('div[data-friendship-id="' + data.friendship.id + '"]').removeClass("follow btn-default").addClass("unfollow btn-primary").html("Following")
				return
		return

# Hover effect to unfollow existing friends
	$('.unfollow').hover (->
		$(this).removeClass("btn-primary").addClass("btn-danger").html("Unfollow")
		return
	), ->
		$(this).removeClass("btn-danger").addClass("btn-primary").html("Following")
		return

	$('.unfollow').click (event) ->
		friend_id = $(this).data("friend-id")
		friendship_id = $(this).data("friendship-id")
		# Prevents hover action from disrupting class change if unfollow is clicked
		$(this).unbind("mouseenter mouseleave")
		$.ajax
			url: "/user_friendships/#{ friendship_id }"
			dataType: "json"
			type: "DELETE"
			success: (data) ->
				console.log(data)
				$('div[data-friend-id="' + friend_id + '"]').removeClass("unfollow btn-danger").addClass("follow btn-default").html("Follow").removeAttr('data-friendship-id')
				return
		return
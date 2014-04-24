#= require jquery
#= require jquery_ujs
#= require js-routes
#= require bootstrap
#= require_tree .


$(document).ready ->

	$.ajaxSetup beforeSend: (xhr) ->
	  xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
	  return
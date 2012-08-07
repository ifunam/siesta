$(document).ready ->
  $(".chzn-select").chosen(allow_single_deselect: true)

  $("form").keypress (e) ->
    false  if e is 13

  $("input").keypress (e) ->
    false  if e.which is 13
	

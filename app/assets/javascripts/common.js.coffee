jQuery.extend 
  set_button_behaviour: ->
    $(".ui-state-default").hover (->
      $(this).addClass "ui-state-hover"
    ), ->
      $(this).removeClass "ui-state-hover"
    
    $(".ui-state-default").css "cursor", "pointer"
 
  open_dialog_with_progressbar: ->
    $("#dialog").dialog(
      width: 260
      height: 130
      bgiframe: true
      modal: true
      hide: "slide"
      open: (event, ui) ->
        $(this).parent().children(".ui-dialog-titlebar").hide()
    ).dialog "open"
    $("#dialog").html "<div id=\"progressbar\"></div><p style=\"font-size:12px\">Cargando, por favor espere...</p>"
    $("#progressbar").progressbar value: 100

  close_dialog_with_progressbar: ->
    $("#dialog").dialog "close"
    $("#dialog").html ""
  
  collection_from_remote_resource: (resource, params) ->
    options =
      url: resource
      async: false
      beforeSend: ->
        $.open_dialog_with_progressbar()

      complete: (request) ->
        $.set_button_behaviour()
        $.close_dialog_with_progressbar()

      type: "get"
    options["data"] = params  unless params == undefined
    $.ajax(options).responseText

  remote_collection_list: (resource, params) ->
    options =
      url: resource
      async: false
      beforeSend: ->
        $.open_dialog_with_progressbar()
      complete: (request) ->
        $.close_dialog_with_progressbar()
      success: (data) ->
        $("#collection").remove()
        $("#paginator").remove()
        $("#filters").after data
      type: "get"
      dataType: "HTML"
    options["data"] = params  unless params is `undefined`
    $.ajax options
    false

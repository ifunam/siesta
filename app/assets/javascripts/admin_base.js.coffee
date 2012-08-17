$(document).ready ->
  $("#search_link").live "click", ->
    resource = $("#search_form").attr("action") + ".js"
    $.remote_collection_list resource, $.param($("#search_form").serializeArray())
    false

  $("#excel_report_link").live "click", ->
    resource = "/managers/students/search.xls?" + $.param($("#search_form").serializeArray())
    document.location.href = resource
    false

  $(".authorize_link").live "click", ->
    url = @getAttribute("link") + ".js"
    options =
      url: url
      dataType: "HTML"
    $.ajax options
    $("#authorization_" + @id).empty()
    $("#authorization_" + @id).html "Solicitud autorizada"

  $(".ajaxed_paginator a").live "click", ->
    $.remote_collection_list @href
    false

  $(".destroy_request_link").live "click", (e) ->
    e.preventDefault()
    $.ajax 
      url: @href 
      dataType: "HTML" 
      async: false 
      type: "get"
    $("#"+this.parentNode.parentNode.parentNode.id).remove()
    false

  $('.date').datepicker(dateFormat: 'dd-mm-yy', changeYear: true)

  false

$(document).ready ->
  $("#search_link").live "click", ->
    resource = $("#search_form").attr("action") + ".js"
    $.remote_collection_list resource, $.param($("#search_form").serializeArray())
    false

  $("#excel_report_link").live "click", ->
    resource = "/managers/students/search.xls?" + $.param($("#search_form").serializeArray())
    document.location.href = resource
    false

  $(".ajaxed_paginator a").live "click", ->
    $.remote_collection_list @href
    false

  false

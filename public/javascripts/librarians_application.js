$(document).ready(function(){

	$('#search_link').live('click', function() {
   		resource = $('#search_form').attr('action') + '.js';
    	$.remote_collection_list(resource, $.param($("#search_form").serializeArray()));
    	return false;
	});

	$(".ajaxed_paginator a").live("click", function() {
        $.remote_collection_list(this.href);
        return false;
    });	

});
$(document).ready(function(){
	$('#search_link').live('click', function() {
    	resource = $('#search_form').attr('action') + '.js';
    	remote_collection_list(resource, $.param($("#search_form").serializeArray()));
    	return false;
	});

	$('.authorize_link').live('click', function() {
    	var url = this.getAttribute('link') + '.js';
    	options = {
        	url: url,
        	dataType: "HTML"
    	};
    	$.ajax(options);
    	$("#authorization_"+this.id).empty();
    	$("#authorization_"+this.id).html('Solicitud autorizada');
	});

	$(".ajaxed_paginator a").live("click", function() {
    	remote_collection_list(this.href);
    	return false;
	});
	
	$('.destroy_user_link').live('click', function() {
        var url = this.getAttribute('link') + '.js';
        options = {
            url: url,
            type: "DELETE"
        };
        $.ajax(options);
        $("#user_"+this.id).empty();
        $("#user_"+this.id).html('Usuario borrado');
    });
});


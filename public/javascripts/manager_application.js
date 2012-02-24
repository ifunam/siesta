$(document).ready(function(){
	$('#search_link').live('click', function() {
    	resource = $('#search_form').attr('action') + '.js';
    	$.remote_collection_list(resource, $.param($("#search_form").serializeArray()));
    	return false;
	});

	$('#excel_report_link').live('click', function() {
    	resource = "/managers/students/search.csv?" + $.param($("#search_form").serializeArray());
      document.location.href = resource;
    	return false;
	});

	current_year = new Date().getFullYear();
	end_year = current_year + 1;
	year_range = current_year + ':' + end_year;
    $('.date').datepicker({ changeYear: true,  changeMonth: true, yearRange: year_range, dateFormat: 'dd-mm-yy' });

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
    	$.remote_collection_list(this.href);
    	return false;
	});
	
	$('.destroy_user_link').live('click', function() {
        var url = this.getAttribute('link') + '.js';
        options = {
            url: url,
			async: false,
            type: "DELETE",
			dataType: "HTML",
			success: function(request) {
	        	$("#user_"+this.id).empty();
		        $("#user_"+this.id).html('Usuario borrado');
			}
        };
        $.ajax(options);
		return false;
    });
});


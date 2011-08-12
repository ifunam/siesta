$(document).ready(function(){
	$('#user_person_attributes_birthdate').datepicker({ changeYear: true,  changeMonth: true, yearRange: '1960:1995', dateFormat: 'dd-mm-yy' });

	$('#new_recover_password').click(function() {
		$('#recover_password_dialog').dialog('open');

		$("#recover_password_dialog").dialog({
			bgiframe: true,
			height: 200,
			modal: true,
			autoOpen: false,
			draggable: false,
			resizable: false
		});

		$.ajax({
			url: "/recover_password/new",
			success: function(data){ $("#recover_password_dialog").html(data); }
		});
	});

	$("#user_request_remote_adscription_id").change(function(){
		options ={
			url: "/user_requests/" + $("#user_request_remote_adscription_id").val() + "/remote_incharge_users.js",
      		dataType: "HTML",
			success: function(data){ $("#remote_user_incharge").html(data); }
    }
   	$.ajax(options);
   	return false;
	});

	$("#user_request_role_id").change(function(){
		if ($("#user_request_role_id").val() == 1) 
		{
			$.ajax({
				url:  "form_dates",
        dataType: "HTML",
				success: function(data){ $("#form_dates").html(data); }
			});
		} else {
			$("#form_dates").html('');
		}
	});

	$("#user_person_attributes_country_id").change(function(){
    	options = {
      		url: '/profile/person_state_list.js?id=' + $("#user_person_attributes_country_id").val(),
      		dataType: "HTML",
      		success: function(data) {
        		$("#person_state_list").html(data);
      		}
    	};
    	$.ajax(options);
	});

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
});

function open_dialog_with_progressbar() {
    $('#dialog').dialog({ width: 260, height: 130, bgiframe: true, modal: true, hide: 'slide', 
    open: function(event, ui) { $(this).parent().children('.ui-dialog-titlebar').hide(); }
    }).dialog('open');
    $('#dialog').html('<div id="progressbar"></div><p style="font-size:12px">Cargando, por favor espere...</p>');
    $( "#progressbar" ).progressbar({value: 100});
}

function close_dialog_with_progressbar() {
    $('#dialog').dialog('close');
    $('#dialog').html('');
}

function collection_from_remote_resource(resource, params) {
  options = {
        url: resource,
        async: false,
        beforeSend: function() {
            open_dialog_with_progressbar();
        },
        complete: function(request) {
            set_button_behaviour();
            close_dialog_with_progressbar();
        },
        type: 'get',
        dataType: "HTML"
    }
  if (params != undefined) {
    options['data'] = params;
  }

  return $.ajax(options).responseText;
}

function remote_collection_list(resource, params) {
    var html = collection_from_remote_resource(resource, params);
    $('#collection').remove();
    $('#paginator').remove();
    $('#filters').after(html);
    return false;
}


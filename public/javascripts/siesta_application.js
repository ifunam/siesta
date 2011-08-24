$.extend( {
	
	open_dialog_with_progressbar: function() {
    	$('#dialog').dialog({ width: 260, height: 130, bgiframe: true, modal: true, hide: 'slide', 
    		open: function(event, ui) { $(this).parent().children('.ui-dialog-titlebar').hide(); }
    	}).dialog('open');
    	$('#dialog').html('<div id="progressbar"></div><p style="font-size:12px">Cargando, por favor espere...</p>');
    	$("#progressbar" ).progressbar({value: 300});
	},

	close_dialog_with_progressbar: function() {
    	$('#dialog').dialog('close');
    	$('#dialog').html('');
	},

    remote_collection_list: function(resource, params) {
    	options = {
        url: resource,
        async: false,
        beforeSend: function() {
            $.open_dialog_with_progressbar();
        },
        complete: function(request) {
            $.close_dialog_with_progressbar();
		},
		success: function(data) {
	    	$('#collection').remove();
	    	$('#paginator').remove();
	    	$('#filters').after(data);
        },
        type: 'get',
        dataType: "HTML"
    	}
    	if (params != undefined) {
        	options['data'] = params;
    	}
    	$.ajax(options);
		return false;
	}
	
});

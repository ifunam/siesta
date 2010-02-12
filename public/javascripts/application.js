$(document).ready(function(){
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
});

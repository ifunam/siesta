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
            url: "/user_requests/" + $("#user_request_remote_adscription_id").val() + "/remote_incharge_users",
            dataType: "HTML",
			success: function(data) {
				$("#remote_user_incharge").html(data);
			}
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
            url: '/profile/person_state_list',
            data: {id: $("#user_person_attributes_country_id").val() },
            dataType: "HTML",
            success: function(data) {
                $("#person_state_list").html(data);
            }
        };
        $.ajax(options);
    });
});

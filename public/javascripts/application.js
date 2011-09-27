$(document).ready(function(){
    $('#user_person_attributes_birthdate').datepicker({ changeYear: true,  changeMonth: true, yearRange: '1960:1995', dateFormat: 'dd-mm-yy' });
	current_year = new Date().getFullYear();
	end_year = current_year + 1;
	year_range = current_year + ':' + end_year;
    $('.date').datepicker({ changeYear: true,  changeMonth: true, yearRange: year_range, dateFormat: 'dd-mm-yy' });

    $('.time').timepickr({convention: 24 });

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

	$("#show_schedule_per_day").click(function() {
		$("#schedule_for_all_day").hide();
		$('#schedule_per_day').show();
	});

	$("#show_schedule_for_all_day").click(function() {
		$("#schedule_per_day").hide();
		$("#schedule_start_at").val('');
		$("#schedule_end_at").val('');
		$('#schedule_for_all_day').show();
	});
	
	$("#schedule_start_at").change(function(){
		start_at = $("#schedule_start_at").val();
		if (start_at != null)  {
			$('#schedule_per_day').find("input.start_at").each(function (i) {
				this.value = start_at;
			});
		}			
	});
	
	$("#schedule_end_at").change(function(){
		end_at = $("#schedule_end_at").val();
		if (end_at != null)  {
			$('#schedule_per_day').find("input.end_at").each(function (i) {
				this.value = end_at;
			});
		}			
	});
	
	$('form a.remove_new_child').live('click', function() {
        $(this).parent().parent().remove();
        return false;
    });

    $('form a.remove_existent_child').live('click', function() {
        $(this).parent().find(".destroy")[0].value = true;
        $(this).parent().parent().hide();
        return false;
    });
});

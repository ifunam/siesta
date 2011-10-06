$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
    var office_cubicle_id = $("#office_cubicle_id").attr("value");
	$('#calendar').fullCalendar({
		editable: false ,
		header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'month',
        height: 500,
        slotMinutes: 15,
        
        loading: function(bool){
            if (bool) 
                $('#loading').show();
            else 
                $('#loading').hide();
        },
        // a future calendar might have many sources.        
        eventSources: [{

            url: '/academics/events?office_cubicle_id='+office_cubicle_id,
            color: 'yellow',
            textColor: 'black',
            ignoreTimezone: false
        }],
        
        timeFormat: 'h:mm t{ - h:mm t} ',
        dragOpacity: "0.5",

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
          // would like a lightbox here.
        },
	});
});


$(document).ready ->
  $(".chzn-select").chosen(allow_single_deselect: true)

  $("form").keypress (e) ->
    false  if e is 13

  $("input").keypress (e) ->
    false  if e.which is 13

  current_year = new Date().getFullYear()
  start_year = current_year - 45 
  end_year = current_year - 15
  year_range = start_year + ':' + end_year
  $(".birthdate").datepicker(changeYear: true,  changeMonth: true, yearRange: year_range, dateFormat: 'dd-mm-yy')

  $("#user_person_attributes_country_id").change ->
    if this.value == '484'
      $("#person_state").show()
    else
      $("#person_state").hide()
      $("#user_person_attributes_state_id").val('')
    false

  false

// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function set_class_name(element, class_name) {
  new Element.ClassNames(element).set(class_name);
}

function hide_element(element) {
  $(element).hide();
}

function check_ids_from_list(form) {
 var ids = $(form).getInputs('checkbox' , 'id[]');
 var n= ids.length;
 for (i=0; i<n; i++) { 
	ids[i].checked = true;
 }
}

function uncheck_ids_from_list(form) {
 var ids = $(form).getInputs('checkbox' , 'id[]');
 var n= ids.length;
 for (i=0; i<n; i++) {
	ids[i].checked = false;
 }
}

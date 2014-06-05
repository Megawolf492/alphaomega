//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.turbolinks
//= require_tree .
//= require jquery_nested_form

var vReady = function(){
	$(".fields").find('.vid').last().children().val("New Video");
};

var wReady = function(){
	$(".fields").find('.pdf').last().children().val("New Worksheet");
};

var qReady = function(){
	$(".fields").find('.quiz').last().children().val("New Quiz");
};

var quReady = function(event){
	var field = event.field;
	var type = field.closest("div.all").attr("difficulty");
	field.find("span.question").children().val(type);
};




$(document).on('nested:fieldAdded:videos', vReady);
$(document).on('nested:fieldAdded:worksheets', wReady);
$(document).on('nested:fieldAdded:quizzes', qReady);
$(document).on('nested:fieldAdded:questions', quReady);



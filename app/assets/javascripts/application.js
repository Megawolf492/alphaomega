//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.turbolinks
//= require_tree .
//= require jquery_nested_form
//= require foundation
//= require magnific-popup
//= require jquery.datetimepicker
//= require select2
//= require ./plugins/rails.validations


$(document).on('nested:fieldAdded:videos', function()
{
	$(".fields").find('.vid').last().children().val("New Video");
});
$(document).on('nested:fieldAdded:worksheets', function()
{
	$(".fields").find('.pdf').last().children().val("New Worksheet");
});
$(document).on('nested:fieldAdded:quizzes', function()
{
	$(".fields").find('.quiz').last().children().val("New Quiz");
});

$(document).foundation();

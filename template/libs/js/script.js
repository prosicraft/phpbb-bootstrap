$(document).ready(function() {

	$("#login-trigger").on("click", function(e) {
		e.preventDefault();

		var $qform = $("#quicklogin-form") || false;
		var $link  = $(this).parent();

		if ($qform) {
			if ($qform.is(":visible")) {
				$qform.hide();
				$link.removeClass("active");
			} else {

				$qform.show();
				$link.addClass("active");
			}
		}
	});

	$("body").on("click", function(e) {
		$("#login-trigger").parent().removeClass("active");
		$("#quicklogin-form").hide();
	});

	$("#quicklogin-form").click(function(e) {
		e.stopPropagation();
	});

	$("#login-trigger").click(function(e) {
		e.stopPropagation();
	});

});
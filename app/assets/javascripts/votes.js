$(function () {
	$(".movies").on("click", ".js-vote", function () {
		var votesPartial = $(this).parent().parent();
		$.ajax({
			url: $(this).attr("data-url"),
			type: 'POST'
		}).done(function(data) {
			votesPartial.empty().append(data.votes);
		});
	});

	$(".movies").on("click", ".js-remove-vote", function () {
		var votesPartial = $(this).parent().parent();
		$.ajax({
			url: $(this).attr("data-url"),
			type: 'POST',
			data: {"_method":"delete"}
		}).done(function(data) {
			votesPartial.empty().append(data.votes);			
		});
	});
});

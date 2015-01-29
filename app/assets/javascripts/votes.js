$(function () {
	$(".movies").on("click", ".js-vote", function () {
		var votesDiv, voteMsg;
		votesDiv = $(this).parent();
		voteMsg = votesDiv.next();
		$.ajax({
			url: $(this).attr("data-url"),
			type: 'POST'
		}).done(function(data) {
			votesDiv.html(data.votes);	
			voteMsg.empty().append(data.vote_msg);
		});
	});

	$(".movies").on("click", ".js-remove-vote", function () {
		var votesDiv, voteMsg;
		voteMsg = $(this).parent();
		votesDiv = voteMsg.prev();
		$.ajax({
			url: $(this).attr("data-url"),
			type: 'POST',
			data: {"_method":"delete"}
		}).done(function(data) {
			voteMsg.empty();
			votesDiv.empty().append(data.votes);			
		});
	});
});

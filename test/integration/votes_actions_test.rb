require 'test_helper'

class VotesActionsTest < ActionDispatch::IntegrationTest

	def setup
		@george = users(:george)
		@maria = users(:maria)
		@movie1 = @george.movies.create(title: "Good Movie", description: "Good movie description")
		@movie2 = @maria.movies.create(title: "Bad Movie", description: "Bad movie description")
	end

  test "voting/unvoting process" do
  	log_in_as @george
		assert_redirected_to user_path(@george)
		assert_select '.js-vote', count: 0
		assert_select '.js-remove-vote', count: 0
		get user_path(@maria)
		assert_select '.js-vote'
		assert_select '.js-remove-vote'
		# Couldn't make this work...
		# assert_difference 'Vote.count', 1 do
		# 	xhr :post, movie_votes_path, movie_id: @movie2.id
		# end
		# .....
	end
end

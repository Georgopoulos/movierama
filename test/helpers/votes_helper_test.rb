require 'test_helper'

class VotesHelperTest < ActionView::TestCase

	def setup
		@user = users(:george)
		@movie = movies(:marias_movie)
		@movie2 = movies(:a_movie)
		# A positive vote from george to marias_movie
		@vote1 = votes(:one)
	end

	test "voted? returns vote object if exists otherwise nil" do
		assert_equal voted?(@user, @movie), @vote1
		assert_equal voted?(@user, @movie2), nil
	end

	test "vote with positive true returns like" do
		assert_equal vote(@vote1), 'like'
	end

end
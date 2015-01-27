# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  movie_id   :integer
#  positive   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class VoteTest < ActiveSupport::TestCase

	def setup
		@vote = votes(:one)
	end

	# test "should be valid" do
	# 	assert @vote.valid?
	# end

  test "should belong to user" do
  	@vote.user_id = nil
  	assert_not @vote.valid?
  end

  test "should belong to a movie" do
  	@vote.movie_id = nil
  	assert_not @vote.valid?
  end

  test "should vote only once for specific user-movie" do
  	@vote.movie = movies(:marias_movie)
  	@vote.save
  	@another_vote = @vote.dup
  	assert_not @another_vote.valid?
  	assert_equal @another_vote.errors.full_messages, ["User can't vote twice for same movie"]
  end

  test "should not be able to vote his/her own movie" do
  	movie = movies(:a_movie)
  	@vote.movie_id = movie.id
  	assert_not @vote.valid?
  	assert_equal @vote.errors.full_messages, ["User can't vote his/her own movie"]
  end
end

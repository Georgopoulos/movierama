require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  
	def setup
		@user1 = users(:maria)
		@user2= users(:george)
		@movie = @user1.movies.create(title: 'Movie', description: 'Movie desc')
	end

  test "should not create vote if user is not registered/logged in" do
  	assert_no_difference 'Vote.count' do
	    post :create, user_id: @user1.id, movie_id: @movie.id, positive: true
	  end
  end

  test "should not create vote if user is movie uploader" do
  	log_in_as @user1
  	assert_no_difference 'Vote.count' do
	    post :create, user_id: @user1.id, movie_id: @movie.id, positive: true
	  end
  end

  test "should create vote for another movie" do
  	log_in_as @user2
  	assert_difference 'Vote.count', 1 do
	    post :create, user_id: @user2.id, movie_id: @movie.id, positive: true
	  end
  end

  test "should not destroy vote if anonymous" do
  	vote = @movie.votes.create(user_id: users(:george).id, positive: false)
		assert_no_difference 'Vote.count' do
			delete :destroy, movie_id: @movie.id, id: vote.id
		end
	end

	test "should destroy vote if right user" do
		log_in_as @user2
  	vote = @movie.votes.create(user_id: @user2.id, positive: false)
		assert_difference 'Vote.count', -1 do
			delete :destroy, movie_id: @movie.id, id: vote.id
		end
	end
end

require 'test_helper'

class MoviesActionsTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:george)
	end

  test "movie submission/edit/delete process" do
		log_in_as @user
		assert_redirected_to user_path(@user)
		# Invalid submission
		assert_no_difference 'Movie.count' do
			post movies_path, movie: {	title: "", description: "" }
		end
		assert_select 'div#error_explanation'
		# Valid submission
		title = "A movie title!"
		description = "A description for this movie..."
		assert_difference 'Movie.count', 1 do
			post movies_path, movie: { title: title, description: description }
		end
		assert_redirected_to user_path(@user)
		follow_redirect!
		assert_match title.titleize, response.body
		assert_match description, response.body
		# Edit movie
		assert_select 'a', text: 'Edit'
		first_movie = @user.movies.first
		get edit_movie_path(first_movie)
		assert_select "title", "Edit movie | MovieRama"
		patch movie_path, movie: { title: "An updated movie title", 
															 description: "An updated movie description" }
		assert_not flash.empty?
		assert_redirected_to @user
		follow_redirect!
		# Destroy movie
		assert_select 'a', text: 'Delete'
		assert_difference "Movie.count", -1 do
			delete movie_path(first_movie)
		end
		# Visit another user
		get user_path(users(:maria))
		assert_select 'a', text: 'Edit', count: 0
		assert_select 'a', text: 'Delete', count: 0
	end
end

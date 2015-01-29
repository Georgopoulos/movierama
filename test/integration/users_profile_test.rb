require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:george)
	end

  test "profile page anonymous or not current user" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", new_movie_path, count: 0
    @user.movies.each do |movie|
      assert_match movie.title.titleize, response.body
      assert_match movie.description, response.body
      assert_select "a[href=?]", edit_movie_path(movie), count: 0
      assert_select "a", text: 'Delete', count: 0
      assert_select ".js-vote", 0
      assert_select ".js-remove-vote", 0
    end
  end

  test "profile page logged in as other user" do
    another_user = users(:maria)
    log_in_as another_user
    follow_redirect!
    assert_select "title", "#{another_user.fullname} | MovieRama"
    get user_path(@user)
    assert_template 'users/show'
    assert_select "title", "#{@user.fullname} | MovieRama"
    @user.movies.each do |movie|
      assert_select "a[href=?]", edit_movie_path(movie), count: 0
      assert_select "a", text: 'Delete', count: 0
      # Render like/hate buttons for not voted movies
      assert_select ".js-vote"
      # Render Remove Vote button if voted before
      assert_select ".js-remove-vote"
    end
  end

  test "profile page logged in as current user" do
    log_in_as @user
    follow_redirect!
    assert_template 'users/show'
    # New movie button is displayed
    assert_select "a[href=?]", new_movie_path
    @user.movies.each do |movie|
      assert_match movie.title.titleize, response.body
      assert_match movie.description, response.body
      # Edit / Delete textlinks are rendered for each movie 
      assert_select "a[href=?]", edit_movie_path(movie)
      assert_select "a", text: 'Delete'
      # Vote / Remove Vote are not render for movie uploader
      assert_select ".js-vote", 0
      assert_select ".js-remove-vote", 0
    end
  end
end

require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  def setup
  	@user = users(:george)
  	@another_user = users(:maria)
  	@movie = movies(:a_movie)
  end

  test "should get new if logged in" do
  	log_in_as @user
  	get :new
  	assert_response :success
  	assert_select "title", "New movie | MovieRama"
  end

  test "should redirect new if not logged in" do
    get :new
    assert_redirected_to login_url
  end

  test "should redirect create if not logged in" do
		assert_no_difference 'Movie.count' do 
			post :create, movie: { 	title: "Yet another good movie", 
															description: "Lorem ipsum, blah, blah, blah..." }
		end
		assert_redirected_to login_url
  end

	test "should get edit if logged in and uploader of movie" do
		log_in_as @user
		get :edit, id: @movie
		assert_response :success
	end

	test "should redirect edit if logged in but not uploader of movie" do
		log_in_as @another_user
		get :edit, id: @movie
		assert_redirected_to root_url
	end

	test "should redirect update if not logged in" do
  	patch :update, id: @movie, movie: { title: "An updated title",
  																			description: "An updated description" }
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test "should redirect update if logged in as another user" do
		log_in_as @another_user
  	patch :update, id: @movie, movie: { title: "An updated title",
  																			description: "An updated description" }
		assert_redirected_to root_url
	end

	test "should update movie if right user" do
		log_in_as @user
		patch :update, id: @movie, movie: { title: "An updated title", 
																				description: "An updated description" }
		assert_redirected_to user_path(@user)
	end

  test "should redirect destroy if not logged in" do
		assert_no_difference 'Movie.count' do 
			delete :destroy, id: @movie
		end
		assert_redirected_to login_url
  end

  test "should redirect destroy if not the uploader of movie" do
  	log_in_as @another_user
  	assert_no_difference 'Movie.count' do 
			delete :destroy, id: @movie
		end
		assert_redirected_to root_url
	end
end

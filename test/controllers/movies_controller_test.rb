require 'test_helper'

class MoviesControllerTest < ActionController::TestCase
  def setup
  	@movie = movies(:a_movie)
  end

  test "should redirect create if not logged in" do
		assert_no_difference 'Movie.count' do 
			post :create, movie: { 	title: "Yet another good movie", 
															description: "Lorem ipsum, blah, blah, blah..." }
		end
		assert_redirected_to login_url
  end

  test "should redirect destroy if not logged in" do
		assert_no_difference 'Movie.count' do 
			delete :destroy, id: @movie
		end
		assert_redirected_to login_url
  end
end

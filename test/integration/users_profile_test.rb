require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:george)
	end

  test "profile page" do
    get user_path(@user)
    assert_template 'users/show'
    # assert_select 'div.pagination'
    @user.movies.paginate(page: 1).each do |movie|
    	assert_match movie.description, response.body
    end
  end
end

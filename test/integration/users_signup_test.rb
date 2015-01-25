require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
    	post users_path, user: {	fullname: "",
								  							email: "invalid_user@mail.com",
								  							password: 						 "foo",
								  							password_confirmation: "bar" }
		end
		assert_template 'users/new'
		assert_select 'div#error_explanation'
		assert_select 'div.alert-danger'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
    	post_via_redirect users_path, user: {	fullname: "Mr User",
														  							email: "mr_user@mail.com",
														  							password: 						 "foobar",
														  							password_confirmation: "foobar" }
		end
		assert_template 'users/show'
		assert is_logged_in?
		assert_select 'div.alert-success'
  end

end

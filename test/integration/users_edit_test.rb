require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = users(:george)		
	end

  test "unsuccessful edit" do
  	log_in_as(@user)
  	get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { fullname: "",
    																email: "invalid@mail",
    																password: 							"123",
    																password_confirmation:	"456" }
		assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
  	get edit_user_path(@user)
  	log_in_as(@user)
  	assert_redirected_to edit_user_path(@user)
  	patch user_path(@user), user: { fullname: "Mr Someone",
  																	email: "mr.someone@mail.com",
  																	password: 							"",
  																	password_confirmation: 	"" }
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal @user.fullname, "Mr Someone"
		assert_equal @user.email, "mr.someone@mail.com"
	end
end

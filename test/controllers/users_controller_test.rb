require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
		@other_user = users(:archer)
	end

	test "should get new" do
		get signup_path # users_new_url
		assert_response :success
	end

	test "should redirect edit when not logged in" do
		get edit_user_path(@user.id)#, params: { id: @user }
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	#test "should redirect update when not logged in" do
	#	patch :update, id: @user, user: { name: @user.name,
	#																		email: @user.email }
	#	assert_not flash.empty?
	#	assert_redirected_to loggin_url
	#end

	test "should redirect edit when logged in as wrong user" do
		log_in_as(@other_user)
		get edit_user_path(@user.id)
		assert flash.empty?
		assert_redirected_to root_url
	end
end

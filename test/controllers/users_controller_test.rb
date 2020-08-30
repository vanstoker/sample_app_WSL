require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:michael)
		@other_user = users(:archer)
	end

	test "should redirect index when not logged in" do
		get users_path
		assert_redirected_to login_url
	end

	test "should get new" do
		get signup_path # users_new_url
		assert_response :success
	end

	test "should redirect edit when not logged in" do
		get edit_user_path(@user.id) #, params: { id: @user }
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	#test "should redirect update when not logged in" do
	#	patch :update, id: @user, user: { name: @user.name, email: @user.email }
	#	assert_not flash.empty?
	#	assert_redirected_to login_url
	#end

	test "should redirect edit when logged in as wrong user" do
		log_in_as(@other_user)
		get edit_user_path(@user.id)
		assert flash.empty?
		assert_redirected_to root_url
	end

	#test "should redirect update when logged in as wrong user" do
	#	log_in_as(@other_user)
	#	patch :update, id: @user, user: { name: @user.name, email: @user.email }
	#	assert flash.empty?
	#	assert_redirected_to root_url
	#end

	test "should redirect destroy when not logged in" do
		assert_no_difference 'User.count' do
			delete :destroy, user_path(@user.id) #id: @user
		end
		assert_redirected_to login_url
	end

#	test "should redirect destroy when logged in as a non-admin" do
#    log_in_as(@other_user)
#    assert_no_difference 'User.count' do
#      delete :destroy, id: @user
#    end
#    assert_redirected_to root_url
#  end
end

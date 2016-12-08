require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:firstuser)
  end
  
  test "user creation when specifying good parameters" do
    post users_path, 
         params: { name: 'fdjksa', password: 'jksdfa' },
         as: :json

    assert_response :created
  end

  test "user can modify password when user is authorized" do
    encoded_credentials = 
      ActionController::HttpAuthentication::Basic.encode_credentials(@user.name,
                                                                     'secretpass')
    put user_path(@user),
           params: { password: 'newpassword' },
           headers: { 'HTTP_AUTHORIZATION': encoded_credentials },
           as: :json

    assert_response :ok
  end

  test 'user can not modify password unless user is authorized' do
    put user_path(@user),
           params: { password: 'newpassword' },
           as: :json

    assert_response :unauthorized
  end

  test 'listing of all users' do
    get users_path,
        as: :json

    users = JSON.parse(response.body)

    assert_equal users[0]['id'], 1
    assert_equal users[0]['name'], 'firstuser'

    assert_response :ok
  end
end

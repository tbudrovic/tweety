require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "user creation when specifying good parameters" do
    post '/users', 
         params: { name: 'fdjksa', password: 'jksdfa' },
         as: :json

    assert_response :created
  end

  test "user can modify password when user is authorized" do
    encoded_credentials = 
      ActionController::HttpAuthentication::Basic.encode_credentials(users(:firstuser).name,
                                                                     'secretpass')
    put '/users/1',
           params: { password: 'newpassword' },
           headers: { 'HTTP_AUTHORIZATION': encoded_credentials },
           as: :json

    assert_response :no_content
  end

  test 'user can not modify password unless user is authorized' do
    put '/users/1',
           params: { password: 'newpassword' },
           as: :json

    assert_response :unauthorized
  end

  test 'listing of all users' do
    get '/users',
        as: :json

    users = JSON.parse(response.body)

    assert_equal users[0]['id'], 1
    assert_equal users[0]['name'], 'firstuser'

    assert_response :ok
  end
end

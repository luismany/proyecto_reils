
require 'test_helper'

class Authentication::UsersControllerTest < ActionDispatch::IntegrationTest

  test "Show get new" do
    get new_user_url
    assert_response :success
    
  end

  test 'Permite crear un usuario' do 
    assert_difference('User.count') do
    post users_url, params: {
      user:{
        email:'juan@vendelo.com',
        username:'juan123',
        password:'123456' }}
    end
    assert_redirected_to productos_path 

  end

end
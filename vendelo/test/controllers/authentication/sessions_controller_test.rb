
require 'test_helper'

class Authentication::SessionsControllerTest < ActionDispatch::IntegrationTest
  # esta funcion devuelve un usuario del fixture users.yml
  def setup
    @user = users(:luis)
  end

  test "Show get new" do
    get new_session_url
    assert_response :success
    
  end

  test 'permite loguearse por Email' do 
    post sessions_url, params: { login: @user.email , password:'123456' }
    assert_redirected_to productos_path 

  end

  test 'permite loguearse por Username' do 
    post sessions_url, params: { login:@user.username, password:'123456' }
    assert_redirected_to productos_path 

  end

end
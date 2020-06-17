require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get root_path
    assert_response :success
    assert_select 'h1', 'Hello World!'
  end
end

require 'test_helper'

class DocumentationControllerTest < ActionDispatch::IntegrationTest
  test "should return API documentation" do
    get "/"

    assert_response 200
  end
end

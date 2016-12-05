require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user should not be created without providing password" do
    user = User.new(name: 'Toni')
    assert_not user.save
  end

  test "user should not be created without providing name" do
    user = User.new(password: 'sth')
    assert_not user.save
  end

  test "user should be created when both username and password are provided" do
    user = User.new(name: 'sth', password: 'sth_else')
    assert user.save
  end

  test "created user should be able to change pasword by specifying new one" do
    user = users(:default)
    user.save
    assert user.update(password: 'newpassword')
  end

  test "user should not be able to set empty password" do
    user = users(:default)
    assert_not user.update(password: '')
  end
end

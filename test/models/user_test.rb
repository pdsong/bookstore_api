require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with a valid email should be valid" do
    user=User.new(email: "test@gmail.com", password_digest: "password")
    assert user.valid?
  end

  test "user with invalid email should be valid" do
    user=User.new(email: "test", password_digest: "password")
    assert_not user.valid?
  end
  test "user with token should be valid" do
    other_user=users(:one)
    user=User.new(email: other_user.email, password_digest: "test")
    assert_not user.valid?
  end

end

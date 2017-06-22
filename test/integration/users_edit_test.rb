require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  # 编辑失败的测试
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
        user: { name: "",
                email: "foo@invalid",
                password: "foo",
                password_confirmation: "bar"

        }
    }
    assert_template 'users/edit'
  end

  # 编辑成功的测试
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path (@user)
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user) ,params: { user: {
        name:name,
        email: email,
        password: "",
        password_confirmation: ""
    }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  #测试友好的转向
  test"successful edit friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user) ,params: { user: {
        name:name,
        email: email,
        password: "",
        password_confirmation: ""
    }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end

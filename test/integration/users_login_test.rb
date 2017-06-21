require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  #捕获继续显示闪现消息的测试
  def setup
    @user = users(:michael)
  end
  test "login with vaild information" do
    get login_path
    assert_template 'sessions/new'
    post login_path params: {
        session: {
            email: @user.email, password: 'password',
        }
    }
    assert_redirected_to @user #检查重定向的地址是否正确
    follow_redirect! #访问重定向的目标地，还确认页面中有零个登陆链接，从而证实登陆链接消失了
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0 #我们期望有0个匹配模式
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    # assert_not flash.empty?
    # get root_path
    # assert flash.empty?
  end

  # 测试用户退出功能
  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: {email: @user.email,password: 'password'}}
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  #测试记住密码
  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
  end
end

require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  #测试密码重置
  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    #电子地址邮件无效
    post password_resets_path, params: { password_reset: { email: @user.email}}
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "example",email: "user@example.com",password: "123456")
  end
  test "should be valid" do
    assert @user.valid?
  end
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  # 测试有效的邮箱格式
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  # 测试唯一的邮箱
  test "email adddresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  #测试邮箱大小写
  test "email should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMple.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  #测试密码长度不为空
  test "password should be present (noblank)" do
    @user.password = @user.password_confirmation = ""*6
    assert_not @user.valid?
  end
  #测试密码最小长度
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a"*5
    assert_not @user.valid?
  end
end

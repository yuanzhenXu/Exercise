class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #登入用户，然后重定向到用户的资料页面
      log_in  user
      #记住密码
      params[:session][:remember_me] == '1' ?  remember(user) : forget(user)
      redirect_back_or  user
    else
      #创建一个错误消息
      flash.now[:danger] = 'Invaild email/password combination'
      render 'new'
    end
  end

  #退出登录
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

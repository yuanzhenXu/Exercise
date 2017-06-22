class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
    # 调试器(如果觉得那部分有问题，就可以在可能导致问题的代码附近加上debugger方法)
    # debugger
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
        flash[:success] = "welcome to the sample app"
        redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Use callbacks to share common setup or constraints between actions.
    #确保用户已登录
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "please log in"
        redirect_to login_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    #确保是正确用户
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    #确保是管理员
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end

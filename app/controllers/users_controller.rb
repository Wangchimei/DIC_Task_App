class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :already_logged_in, only: [:new, :create]
  before_action :unauthorized_user, only: [:show]
  skip_before_action :authenticated_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to tasks_path
      flash[:notice] = "ログインしました"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def unauthorized_user
    if current_user != @user && !current_user.admin?
      redirect_to tasks_path
      flash[:notice] = "権限がありません"
    end
  end
end

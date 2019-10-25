class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :logged_in, only: [:new, :create]
  before_action :unauthorized_user, only: [:edit, :show]
  skip_before_action :authenticated_user, only: [:new, :create]

  def index
    @users = User.all
  end

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

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "更新しました"
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @user.destroy
    flash[:notice] = "アカウントを削除しました"
    redirect_to new_user_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

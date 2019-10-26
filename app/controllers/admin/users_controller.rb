class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :toggle_admin, :destroy]
  before_action :admin_user

  def index
    @users = User.all.order(created_at: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
      flash[:notice] = "ユーザーを作成しました"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path
      flash[:notice] = "ユーザーを更新しました"
    else
      render :edit
    end
  end

  def toggle_admin
    if current_user == @user
      if rollback?
        redirect_to admin_users_path
        flash[:notice] = "権限を変更できません"
      else
        redirect_to tasks_path
        current_user.toggle!(:admin)
        flash[:notice] = "管理者権限がなくなりました"
      end
    else
      @user.toggle!(:admin)
      redirect_to admin_users_path
      flash[:notice] = "権限を変更しました"
    end
  end

  def destroy
    if current_user != @user
      @user.destroy
      redirect_to admin_users_path
      flash[:notice] = "ユーザーを削除しました"
    else
      redirect_to admin_users_path
      flash[:notice] = "ユーザーを削除できません"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_user
    raise ActionController::RoutingError, "アクセスする許可がありません" unless current_user.admin?
  end

  def rollback?
    User.where(admin:true).where.not(id: current_user.id).count == 0
  end
end

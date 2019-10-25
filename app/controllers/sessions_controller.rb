class SessionsController < ApplicationController
  before_action :logged_in, only: [:new, :create]
  skip_before_action :authenticated_user, only: [:new, :create]

  def new; end

  def create
  user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to tasks_path
      flash[:notice] = 'ログインしました'
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが違います"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_path
    flash[:notice] = 'ログアウトしました'
  end
end

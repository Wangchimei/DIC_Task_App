class SessionsController < ApplicationController
  def new
  end

  def create
  @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in
      redirect_to tasks_path
      flash[:notice] = 'ログインしました'
    else
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_path
    flash[:notice] = 'ログアウトしました'
  end
end

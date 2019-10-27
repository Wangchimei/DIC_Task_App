module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def already_logged_in
    if logged_in?
      redirect_to tasks_path
      flash[:notice] = "既にログイン中です"
    end
  end

  def authenticated_user
    unless logged_in?
      redirect_to new_session_path
      flash[:notice] = "ログインしてください"
    end
  end
end

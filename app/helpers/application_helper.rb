module ApplicationHelper
  def log_in
    session[:user_id] = user.id
  end

  def log_out
    
  end
end

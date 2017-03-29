module UsersHelper
  def current_user
    if session[:id]
      @current_user ||= User.find_by_id(session[:id])
    end
  end
  def logged_in?
    !current_user.nil?
  end

  def permission?
    if current_user.role == :user

    end
    if current_user.role == :moderator

    end
    if current_user.role == :admin

    end
  end
  
end

class UsersController < Clearance::UsersController

  def create
    @user = user_from_params
    if @user.save(context: :create_user)
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end

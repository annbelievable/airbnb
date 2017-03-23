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

  def index
    @users = User.all.page params[:page]
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end

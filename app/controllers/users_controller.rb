class UsersController < Clearance::UsersController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

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
  end

  def edit
    if @user.id == current_user.id
    else
      redirect_to user_path(current_user)
    end
  end

  def update
  end

  def destroy
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end
end

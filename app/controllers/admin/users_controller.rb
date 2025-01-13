class Admin::UsersController < Admin::ApplicationController
  # before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    first_set_random_values(user)
    if user.save
      redirect_to admin_users_path, notice: "ユーザーを作成しました"
    else
      redirect_to new_admin_user_path, alert: "ユーザーの作成に失敗しました"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name)
  end

  def first_set_random_values(user)
    random_login_id = SecureRandom.alphanumeric(8)
    random_first_password = SecureRandom.alphanumeric(8)
    user.login_id = random_login_id
    user.password = random_first_password
    user.password_confirmation = random_first_password
    user.first_login_password = random_first_password
  end
end
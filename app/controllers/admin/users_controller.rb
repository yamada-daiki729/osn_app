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
    if user.save
      redirect_to admin_users_path, notice: "ユーザーを作成しました"
    else
      redirect_to new_admin_user_path, alert: "ユーザーの作成に失敗しました"
    end
  end


  private

  def user_params
    params.require(:user).permit(:login_id, :password, :password_confirmation)
  end
end
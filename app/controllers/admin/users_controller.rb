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

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id == @user.id
      redirect_to admin_users_path, alert: "自分自身の編集はできません"
    end
  end

  def update
    @user = User.find(params[:id])
    update_params = user_edit_params.to_h
    if update_params[:password].blank?
      update_params.delete(:password)
      update_params.delete(:password_confirmation)
    end

    if @user.update(update_params)
      redirect_to admin_users_path, notice: "ユーザーを更新しました"
    else
      redirect_to edit_admin_user_path, alert: "ユーザーの更新に失敗しました"
    end
  end

  def destroy

    if current_user.id == params[:id].to_i
      redirect_to admin_users_path, alert: "自分自身を削除することはできません"
      return
    end
    user = User.find(params[:id])

    if user.admin_type != "general" && current_user.admin_type != "super_admin"
      redirect_to admin_users_path, alert: "管理者削除権限がありません"
      return
    end

    if user.admin_type != "general" && User.where.not(admin_type: "general").count == 1
      redirect_to admin_users_path, alert: "最後の管理者ユーザーを削除することはできません"
      return
    end
    user.destroy
    redirect_to admin_users_path, notice: "ユーザーを削除しました"
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

  def user_edit_params
    params.require(:user).permit(:name, :admin_type, :login_id, :password, :password_confirmation)
  end
end
class PasswordsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_first_login
  skip_before_action :login_and_first_change_password_check

  def first_change
  end

  def update_first_password
    if current_user.update(password: password_params[:password],
                         password_confirmation: password_params[:password_confirmation],
                         first_change_password_at: Time.current,
                         first_login_password: nil)
      bypass_sign_in(current_user)
      redirect_to root_path, notice: 'パスワードを変更しました'
    else
      render :first_change, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def check_first_login
    if current_user.first_change_password_at.present?
      redirect_to root_path, alert: 'パスワードは既に変更済みです'
    end
  end
end
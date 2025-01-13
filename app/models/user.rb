class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :authentication_keys => [:login_id]

  enum :admin_type, { general: 0, admin: 1, super_admin: 2 }

  validate :not_login_id_same_as_password
  validate :not_password_is_password

  def not_login_id_same_as_password
    if login_id == password
      errors.add(:login_id, "ログインIDとパスワードが同じです, 横着すな！")
    end
  end

  def not_password_is_password
    if password == "password"
      errors.add(:password, "そんな横着なpasswordは使えません！hahahaha")
    end
  end

  # ユーザー名で検索
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login_id = conditions.delete(:login_id)
      where(conditions).where(login_id: login_id).first
    else
      where(conditions).first
    end
  end

  # 登録時に email を不要にする
  def email_required?
    false
  end
  def email_changed?
    false
  end
end

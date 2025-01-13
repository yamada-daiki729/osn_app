class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :login_and_first_change_password_check

  private

  def login_and_first_change_password_check
    if user_signed_in?
      if current_user.first_change_password_at.nil?
        redirect_to first_password_change_path
      end
    end
  end
end

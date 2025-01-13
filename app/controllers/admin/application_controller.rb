class Admin::ApplicationController < ApplicationController
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :admin_check

  def admin_check
    if current_user.admin_type == "general"
      redirect_to root_path, alert: "権限がありません"
    end
  end
end

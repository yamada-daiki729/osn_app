# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    if current_user.first_change_password_at.nil?
      current_user.update(first_login_at: Time.current) if current_user.first_login_at.nil?
      redirect_to first_password_change_path
    else
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end
end

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def create
    @user = sign_in(user_params)
    user_path(current_user.id)
    flash[:notice] = "Signed in successfully."

    @user = sign_up(user_params)
    user_path(current_user.id)
    flash[:notice] = "Welcome! You have signed up successfully."
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def destroy
    @user = log_out(user_params)
    root_path
    flash[:notice] = "Signed out successfully."
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end

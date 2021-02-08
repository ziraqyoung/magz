class ApplicationController < ActionController::Base
  add_flash_types :success, :warning, :notice, :alert

  protected

    def redirect_if_not_signed_in
      redirect_to(login_path, warning: "Please login or Create a free account to access all App features") unless user_signed_in?
    end

    def redirect_if_signed_in
      redirect_to root_path if user_signed_in?
    end
end

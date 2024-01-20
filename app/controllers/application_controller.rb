class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :authenticate

  private

  def authenticate
    if (session_record = Session.find_by_id(cookies.signed[:session_token]))
      Current.session = session_record
    else
      redirect_to login_path
    end
  end

  def admin?
    unless Current.user.admin?
      redirect_to root_path, notice: "You are not authorized to view that page"
    end
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
  end
end

class HomeController < ApplicationController
  def index
    @organization = Current.user.organization
    @recent_reports = Report.where(user_id: Current.user.id).order(updated_at: :desc).limit(4).to_a
  end
end

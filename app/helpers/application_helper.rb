module ApplicationHelper
  def admin?
    unless Current.user.admin?
      redirect_to root_path, notice: "You are not authorized to view that page"
    end
  end
end

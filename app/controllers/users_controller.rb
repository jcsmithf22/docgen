class UsersController < ApplicationController
  before_action :admin?

  def index
    @users = User.where(organization_id: Current.user.organization.id)
  end
end
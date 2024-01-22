class UsersController < ApplicationController
  before_action :admin?

  def index
    @organization = Current.user.organization
    # @users = @organization.users
    @users = User.where(organization_id: Current.user.organization_id)
    # @users = Current.user.organization.users
  end
end
class HomeController < ApplicationController
  def index
    @organization = Current.user.organization
  end
end

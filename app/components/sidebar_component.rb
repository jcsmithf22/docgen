# frozen_string_literal: true

class SidebarComponent < ViewComponent::Base
  include ApplicationHelper

  def initialize(user:)
    @user = user
  end

end

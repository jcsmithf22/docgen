# frozen_string_literal: true

class NavigationComponent < ViewComponent::Base
  def initialize(page:, organization:)
    @page = page
    @organization = organization
  end

end

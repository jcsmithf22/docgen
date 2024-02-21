# frozen_string_literal: true

class SuccessComponent < ViewComponent::Base
  def initialize(message:)
    @message = message
  end

end

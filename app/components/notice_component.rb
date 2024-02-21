# frozen_string_literal: true

class NoticeComponent < ViewComponent::Base
  def initialize(message:)
    @message = message
  end

end

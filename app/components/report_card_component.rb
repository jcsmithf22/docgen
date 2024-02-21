# frozen_string_literal: true

class ReportCardComponent < ViewComponent::Base
  def initialize(report_card:)
    @report = report_card
  end

end

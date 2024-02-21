# frozen_string_literal: true

class ReportListItemComponent < ViewComponent::Base
  include ReportsHelper

  def initialize(report_list_item:)
    @report = report_list_item
  end

end

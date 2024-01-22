class ReportsController < ApplicationController
  def create
    report_id = Report.next_report_id(Current.user.organization_id)
    @report = Report.create(organization_id: Current.user.organization_id, user: Current.user, report_id: report_id)

    redirect_to report_build_path(report_id: @report.id, id: :general)
  end
end

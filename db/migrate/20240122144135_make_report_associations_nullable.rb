class MakeReportAssociationsNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :reports, :team_id, true
    change_column_null :reports, :site_raised_by_id, true
    change_column_null :reports, :site_responsible_id, true
    change_column_null :reports, :product_id, true
    change_column_null :reports, :error_id, true
  end
end

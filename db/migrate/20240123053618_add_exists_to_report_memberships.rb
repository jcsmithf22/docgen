class AddExistsToReportMemberships < ActiveRecord::Migration[7.1]
  def change
    add_column :report_memberships, :exists, :boolean
  end
end

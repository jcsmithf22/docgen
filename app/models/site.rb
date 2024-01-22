class Site < ApplicationRecord
  belongs_to :organization
  has_many :raised_reports, class_name: "Report", foreign_key: "site_raised_by_id"
  has_many :responsible_reports, class_name: "Report", foreign_key: "site_responsible_id"
end

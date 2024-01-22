class ReportMembership < ApplicationRecord
  belongs_to :report
  belongs_to :user, optional: true
end

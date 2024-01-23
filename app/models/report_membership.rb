class ReportMembership < ApplicationRecord
  belongs_to :report
  belongs_to :user, optional: true

  validates :role, presence: true
  validates :name, presence: true, unless: :user_exists?
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: :user_exists?
  validates :user_id, presence: true, if: :user_exists?

  def user_exists?
    exists == true
  end
end

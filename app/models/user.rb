class User < ApplicationRecord
  has_secure_password

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end
  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  enum role: { admin: 'admin', member: 'member' }

  belongs_to :organization
  has_many :memberships
  has_many :teams, through: :memberships

  has_many :owned_teams, class_name: 'Team', foreign_key: 'owner_id'

  has_many :action_memberships
  has_many :actions, through: :action_memberships

  has_many :report_memberships
  has_many :reports_member_of, through: :report_memberships, source: :report

  has_many :reports

  has_many :sessions, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }

  normalizes :email, with: -> { _1.strip.downcase }

  # before_validation if: :email_changed?, on: :update do
  before_validation if: :will_save_change_to_email?, on: :update do
    self.verified = false
  end

  # after_update if: :password_digest_previously_changed? do
  after_update if: :saved_change_to_password_digest? do
    sessions.where.not(id: Current.session).delete_all
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

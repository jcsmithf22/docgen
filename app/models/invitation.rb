class Invitation < ApplicationRecord
  belongs_to :organization

  before_create :generate_token

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  normalizes :email, with: -> { _1.strip.downcase }

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(32)
    self.accepted = false
  end

end

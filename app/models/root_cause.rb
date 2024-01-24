class RootCause < ApplicationRecord
  belongs_to :report
  belongs_to :organization

  has_many :actions, dependent: :destroy
  has_many :attachments, as: :attached, dependent: :destroy

  validates :title, :statement, :description, presence: true
  validates :verification_description, :verified_date, presence: true, if: :verified?

  def verified?
    verified == true
  end
end

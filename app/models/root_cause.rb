class RootCause < ApplicationRecord
  belongs_to :report
  belongs_to :organization

  has_many :actions, dependent: :destroy
  has_many :attachments, as: :attached, dependent: :destroy
end

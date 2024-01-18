class Team < ApplicationRecord
  belongs_to :organization
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true
end

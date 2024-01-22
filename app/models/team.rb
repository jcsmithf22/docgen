class Team < ApplicationRecord
  belongs_to :organization
  belongs_to :owner, class_name: 'User'
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :actions
  has_many :reports

  validates :name, presence: true
end

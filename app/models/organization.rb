class Organization < ApplicationRecord
  has_many :users
  has_many :teams
  has_many :reports
  has_many :root_causes
  has_many :actions

  has_many :sites, strict_loading: false
  # can't use errors as a relation name
  has_many :error_codes, class_name: "Error", strict_loading: false
  has_many :products, strict_loading: false

  validates :name, presence: true
end

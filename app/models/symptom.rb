class Symptom < ApplicationRecord
  belongs_to :report
  belongs_to :organization

  validates :symptom, presence: true
  validates :description, presence: true
end

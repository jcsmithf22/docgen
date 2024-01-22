class Symptom < ApplicationRecord
  belongs_to :report
  belongs_to :organization
end

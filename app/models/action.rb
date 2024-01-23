class Action < ApplicationRecord
  belongs_to :report
  belongs_to :organization
  belongs_to :team
  belongs_to :user
  belongs_to :root_cause, optional: true

  has_many :action_memberships, dependent: :destroy
  has_many :members, through: :action_memberships, source: :user

  enum action_type: { era: 'ERA', ica: 'ICA', pca: 'PCA', pra: 'PRA' }

  accepts_nested_attributes_for :members, allow_destroy: true, reject_if: :all_blank
end

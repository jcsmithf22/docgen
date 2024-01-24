class Action < ApplicationRecord
  belongs_to :report
  belongs_to :organization
  belongs_to :team, optional: true
  belongs_to :user
  belongs_to :root_cause, optional: true

  has_many :action_memberships, dependent: :destroy
  has_many :members, through: :action_memberships, source: :user

  enum action_type: { era: 'ERA', ica: 'ICA', pca: 'PCA', pra: 'PRA' }

  accepts_nested_attributes_for :action_memberships, allow_destroy: true #, reject_if: :all_blank

  validates :title, :description, :due_date, :action_type, presence: true
  validates :verification_description, :verified_date, presence: true, if: :verified?
  validates :validation_description, :validated_date, presence: true, if: :validated?
  validates :removed_date, presence: true, if: :removed?
  validates :implemented_date, presence: true, if: :implemented?

  validates :root_cause_id, presence: true, if: :root_cause_required?

  # after_initialize :build_default_action_membership

  def self.build_with_membership(action_attributes = {}, membership_attributes = {})
    action = Action.new(action_attributes)

    # Build the action_membership with the given attributes
    action.action_memberships.build(membership_attributes)

    action
  end

  def verified?
    verified == true
  end

  def validated?
    validated == true
  end

  def implemented?
    implemented == true
  end

  def removed?
    removed == true
  end

  def root_cause_required?
    pca? || pra?
  end

  private

  # def build_default_action_membership
  #   # Build a default action_membership only if it's a new record and has no memberships
  #   action_memberships.build if self.new_record? && action_memberships.empty?
  # end

end

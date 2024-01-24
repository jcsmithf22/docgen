class ActionMembership < ApplicationRecord
  belongs_to :action
  belongs_to :user

  validates :user_id, presence: true
end

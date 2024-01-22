class ActionMembership < ApplicationRecord
  belongs_to :action
  belongs_to :user
end

class Attachment < ApplicationRecord
  belongs_to :attached, polymorphic: true
end

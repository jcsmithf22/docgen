class Session < ApplicationRecord
  belongs_to :user, strict_loading: false
 
  before_create do
    self.user_agent = Current.user_agent
    self.ip_address = Current.ip_address
  end
end

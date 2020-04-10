class UserEvent < ApplicationRecord
  self.primary_keys = :user_id, :event_id
  validates :assistance, presence: true
end

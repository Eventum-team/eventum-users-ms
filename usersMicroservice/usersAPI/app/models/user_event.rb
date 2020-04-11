class UserEvent < ApplicationRecord
  self.primary_keys = :user_id, :event_id
  validates :assistance, inclusion: { in: [true, false] }
  belongs_to :user
end

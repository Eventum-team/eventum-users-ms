class UserGroup < ApplicationRecord
  self.primary_keys = :user_id, :group_id
end

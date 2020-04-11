class UserGroup < ApplicationRecord
  self.primary_keys = :user_id, :group_id
  validates :status, format: { with: /\Aregular\Z|\Aadmin\Z/, message: "status must be either regular or admin" }
  belongs_to :user
end

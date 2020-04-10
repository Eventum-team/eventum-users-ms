class User < ApplicationRecord
  validates :name, presence: true
  validates :phone_number, presence: true, format: { with: /\A[3][0-9]{9}\Z/,
                                                     message: "require a number of 10 digits that begins with 3" }

end

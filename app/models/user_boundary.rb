class UserBoundary < ApplicationRecord
  self.table_name = "users_boundaries"
  belongs_to :user
  belongs_to :boundary
end

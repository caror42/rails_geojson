class UserBoundary < ApplicationRecord
  self.table_name = "boundaries_users"

  belongs_to :user
  belongs_to :boundary
end

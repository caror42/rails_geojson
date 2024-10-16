# == Schema Information
#
# Table name: boundaries_users
#
#  user_id     :bigint           not null
#  boundary_id :bigint           not null
#
class UserBoundary < ApplicationRecord
  #TODO: change table name to be more intuitive
  self.table_name = "boundaries_users"

  belongs_to :user
  belongs_to :boundary
end

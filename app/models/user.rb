# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string
#  token      :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :user_boundary, dependent: :destroy
  has_many :boundaries, through: :user_boundary
  after_create :generate_uuid #after create? so it only is triggered once

  private

  def generate_uuid
    self.token = SecureRandom.uuid
    self.save
  end
end

# == Schema Information
#
# Table name: boundaries
#
#  id          :bigint           not null, primary key
#  minx        :float
#  maxx        :float
#  miny        :float
#  maxy        :float
#  coordinates :jsonb
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Boundary < ApplicationRecord
end

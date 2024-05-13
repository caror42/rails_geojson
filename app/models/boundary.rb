class Boundary < ApplicationRecord
    def self.make
        Boundary.create(
            minx: 0.3,
            maxx: 1.3,
            miny: 0.31,
            maxy: 1.31
        )
        return "hey"
    end
end

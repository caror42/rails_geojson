class Boundary < ApplicationRecord
    def make
        #boundary = Boundary.new(:minx => 0.3, :maxx => 1.3, :miny => 0.31, :maxy => 1.31,  :coordinates => "I am on Railsyeah!")
        # attributes = {minx: 0.3, maxx: 1.3, miny: 0.31, maxy: 1.31,  coordinates: "I am on Railsyeah!"}
        # boundary = Boundary.new(attributes)
        Boundary.create(
            minx: 0.3,
            maxx: 1.3,
            miny: 0.31,
            maxy: 1.31,
            coordinates: "I am on Railsyeah!"
        )
        return "hey"
    end
end

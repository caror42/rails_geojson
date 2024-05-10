class Boundary < ApplicationRecord
    def create
        # boundary = Boundary.new(minx: 0.3, maxx: 1.3, miny: 0.31, maxy: 1.31,  coordinates: "I am on Railsyeah!")
        # boundary.save
        promise = Concurrent::Promise.execute { boundary = Boundary.new(minx: 0.3, maxx: 1.3, miny: 0.31, maxy: 1.31,  coordinates: "I am on Railsyeah!")}

        promise.then do |result|
            boundary.save
        end
    end
end

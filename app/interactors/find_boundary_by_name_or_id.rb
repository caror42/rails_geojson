module FindBoundaryByNameOrId
    def self.find_by_name(name)
        return Boundary.find_by_name(name)
    end
    def self.find_by_id(id)
        return Boundary.find_by_id(id)
    end
end
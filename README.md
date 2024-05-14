# README

Current project adresses part 1 (testing if a point is in a polygon), with ongoing testing implementation

Model: Boundary\
Attributes:\
&nbsp;    name: String,\
&nbsp;    minx: Float,\
&nbsp;    maxx: Float,\
&nbsp;    miny: Float,\
&nbsp;    maxy: maxy,\
&nbsp;    coordinates: JSON (specifficaly stores a 2d array of floats)\

API Routes

* POST 'inside', to: 'application#inside'
    Primarily created for figuring stuff out, not really relevant
* POST 'boundary', to: 'application#boundary'
    Create a Boundary Model Instance!!
    QUESTION: Right now your json needs a "name" field to name the boundary instance,
    but could be modified to save a zipcode and be able to save a zipcode
    -- what is the best field to search for boundaries by?
* GET 'boundary/:name', to: 'application#get_boundary'
    Retrieves a Boundary instance from the database by name
* DELETE 'boundary/:name', to: 'application#delete_boundary'
    Deletes a Boundary instance from the database by name
* POST 'inside/:name', to: 'application#inside_by_name'
    Tests whether a point is in the Boundary of that name
    Request must include a json with a "point" field containing a 2 element array of floats
    Ex: 
        {
            "point": [-79.0594942, 35.911696]
        }

Other General Questions

* I use a json_to_polygon method in a couple places... would there be a good place to centralize this functionality?
* General formatting stuff with what will be passed in requests/desired routes
* Edgecases: like if the point is on the boundary

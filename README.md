# README

This API-Only application manages users and geojson boundaries.

 * Users:
Users are identified by their token during HTTP calls.
Users can be an admin or a non-admin, with varying permissions.
Admins CAN:
-- view all users and their information
-- create any user
-- update any user
-- delete any user
Non-Admins CAN:
-- view their own user
-- delete their own user

* Boundaries
Boundaries are valid [geojsons](https://geojson.org/). [create your own here](https://geojson.io/).
Boundaries can be public or private.
The inside_polygon interactor can be used to determine whether a point is inside a given boundary.
-- calculated via horizontal scan

* User-boundary relationship
Users and boundaries are related through a third model, user_boundary, which pairs user ids with boundary ids based on the user token present when a boundary is created.
All users have access to boundaries they made and public boundaries.
Admin users have access to all boundaries.

* All core functionality is tested.

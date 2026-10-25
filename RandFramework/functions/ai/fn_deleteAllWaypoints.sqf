//Deletes every waypoint of a group
params ["_group"];

while {(count (waypoints _group)) > 0} do {
	deleteWaypoint ((waypoints _group) select 0);
};

//Deletes every waypoint of a group
params ["_group"];

for "_i" from (count waypoints _group) - 1 to 0 step -1 do {
	deleteWaypoint [_group, _i];
};

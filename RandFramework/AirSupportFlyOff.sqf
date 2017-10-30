if (isServer) then {
	
	if (!isNil "airSup1") then {
		
		while {(count (waypoints group airSup1)) > 0} do {
			deleteWaypoint ((waypoints group airSup1) select 0);
		};
		_airSupWP1 = group airSup1 addWaypoint [[0,0,100],10];
		_airSupWP1 setWaypointType "MOVE";
		_airSupWP1 setWaypointSpeed "FULL";
		_airSupWP1 setWaypointBehaviour "SAFE";	
	};

	if (!isNil "airSup2") then {
		
		while {(count (waypoints group airSup2)) > 0} do {
			deleteWaypoint ((waypoints group airSup2) select 0);
		};
		_airSupWP2 = group airSup1 addWaypoint [[0,0,100],10];
		_airSupWP2 setWaypointType "MOVE";
		_airSupWP2 setWaypointSpeed "FULL";
		_airSupWP2 setWaypointBehaviour "SAFE";	
	};

};
chopper1Landing2 = false; 
publicVariable "chopper1Landing2";

//hint (format ["triger thisList: %1", count thisList]);

while {(count (waypoints group chopper1D)) > 0} do {
	deleteWaypoint ((waypoints group chopper1D) select 0);
};

_flyToLZ2 = group chopper1D addWaypoint [getPos heliPad1,0,0];
_flyToLZ2 setWaypointType "MOVE";
_flyToLZ2 setWaypointSpeed "FULL";
_flyToLZ2 setWaypointBehaviour "CARELESS";
_flyToLZ2 setWaypointCombatMode "BLUE";
_flyToLZ2 setWaypointStatements ["true", "(vehicle this) LAND 'LAND'; chopper1Landing2 = true; publicVariable ""chopper1Landing2"""];

//hint "Returning to base";
waitUntil {chopper1 distance2D heliPad1 < 300;};

if (((bPOW1InGroup || bPOW2InGroup) && (bObj1Completed || bObj2Completed)) || (bObj1Completed && bObj2Completed)) then {
	[HQMan,"land"] remoteExec ["sideRadio",0,true];
	setWind [0,0,true]
};

waitUntil {chopper1Landing2 && (isTouchingGround chopper1 || {!canMove chopper1})};

while {(count (waypoints group chopper1D)) > 0} do {
	deleteWaypoint ((waypoints group chopper1D) select 0);
};

if (((bPOW1InGroup || bPOW2InGroup) && (bObj1Completed || bObj2Completed)) || (bObj1Completed && bObj2Completed)) then {
	"end" call remoteExec ["playMusic",0,false];
};



//play 3d sound, welcome home


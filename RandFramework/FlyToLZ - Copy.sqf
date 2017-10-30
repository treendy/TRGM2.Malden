_first_parameter = (_this select 3) select 0;

//hint (format ["Total Units: %1", _first_parameter]);

while {(count (waypoints group chopper1D)) > 0} do {
	deleteWaypoint ((waypoints group chopper1D) select 0);
};

_x = getPos chopper1 select 0;
_y = getPos chopper1 select 1;
_flyToLZ = group chopper1D addWaypoint [[_x+500,_y+500],0,0];
_flyToLZ setWaypointType "TR UNLOAD";
_flyToLZ setWaypointSpeed "FULL";
_flyToLZ setWaypointBehaviour "CARELESS";
_flyToLZ setWaypointCombatMode "BLUE";
_flyToLZ setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"];
//heliPad1

//waitUntil {{!alive _x || !(_x in (chopper1 select 0))} count (units _infGrp) == count (units _infGrp)};
//waitUntil {count units chopper1 == 1;};
waitUntil {isTouchingGround chopper1 || {!canMove chopper1}};

_bUnitsInChopper = true;
_bUnitsStillInChopper = false;
while {true} do {
	{
		hint "AGHHH";
		//hint (format ["hmm: %1", str(vehicle _x)]); 
		//_bUnitsStillInChopper = false;
		if (str(vehicle _x) == "chopper1") then {
			_bUnitsStillInChopper = true;
			//hint "adsfasd";
		};
		
	} forEach playableUnits;
	sleep 1;
	if (!_bUnitsStillInChopper) exitWith {true};
	
};
//hint (format ["UnitsIn2: %1", _bUnitsInChopper]); 

waitUntil {!_bUnitsInChopper};

_flyToLZ2 = group chopper1D addWaypoint [getPos heliPad1,0,0];
_flyToLZ2 setWaypointType "TR UNLOAD";
_flyToLZ2 setWaypointSpeed "FULL";
_flyToLZ2 setWaypointBehaviour "CARELESS";
_flyToLZ2 setWaypointCombatMode "BLUE";
_flyToLZ2 setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"];
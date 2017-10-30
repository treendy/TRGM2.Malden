#include "../setUnitGlobalVars.sqf";	

if (isNil "FinalMusicStarted") then {
			FinalMusicStarted = false;
			publicVariable "FinalMusicStarted";
};

if (RadioMusicFilename != "" && !FinalMusicStarted) then {
	FinalMusicStarted = true;
	publicVariable "FinalMusicStarted";
	sleep 5;
	_missiondir = call { private "_arr"; _arr = toArray str missionConfigFile; _arr resize (count _arr - 15); toString _arr };
	playSound3D [_missiondir + "sound\" + RadioMusicFilename + ".ogg",rad1,true,getPosASL rad1,0.2,1,0];
 };


hint "Extraction chopper inbound";

//_first_parameter = (_this select 3) select 0;

chopper1Landing = false; 
publicVariable "chopper1Landing";

chopper1 removeAction 0;

//hint (format ["Total Units: %1", _first_parameter]);

while {(count (waypoints group chopper1D)) > 0} do {
	deleteWaypoint ((waypoints group chopper1D) select 0);
};
while {(count (waypoints group chopper2D)) > 0} do {
	deleteWaypoint ((waypoints group chopper2D) select 0);
};

_caller = _this select 0;

_x = getPos _caller select 0;
_y = getPos _caller select 1;
_flyToLZ = group chopper1D addWaypoint [[_x,_y],0,0];
_flyToLZ setWaypointType "MOVE";
_flyToLZ setWaypointSpeed "FULL";
_flyToLZ setWaypointBehaviour "CARELESS";
_flyToLZ setWaypointCombatMode "BLUE";
_flyToLZ setWaypointStatements ["true", "(vehicle this) LAND 'LAND'; chopper1Landing = true; publicVariable ""chopper1Landing"""];
//heliPad1
_flyToLZ2 = group chopper2D addWaypoint [[_x,_y],0,0];
_flyToLZ2 setWaypointType "LOITER";
_flyToLZ2 setWaypointLoiterRadius 100;
_flyToLZ2 setWaypointSpeed "FULL";


waitUntil {chopper1Landing && (isTouchingGround chopper1 || {!canMove chopper1})};

player removeAction 0;

while {(count (waypoints group chopper1D)) > 0} do {
	deleteWaypoint ((waypoints group chopper1D) select 0);
};

_mrkExtractLZ = createMarker ["extractLZ", getPos chopper1D]; 
_mrkExtractLZ setMarkerShape "ICON";
_mrkExtractLZ setMarkerSize [1,1];
_mrkExtractLZ setMarkerColor "ColorBlue";
_mrkExtractLZ setMarkerType "mil_end";
_mrkExtractLZ setMarkerText "Extraction LZ";

hint "GET IN!";


chopper1 addAction ["Return to Base", "RandFramework\FlyToBase.sqf"]


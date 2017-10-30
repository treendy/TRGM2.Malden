//_possitionParam = (_this select 3) select 0;
_possitionParam = _this select 0;

_distance1 = getMarkerPos "mrkFirstLocation" distance _possitionParam;
_distance2 = getMarkerPos "mrkSecondLocation" distance _possitionParam;

_flatPos = nil;
_flatPos = [_possitionParam , 0, 200, 4, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
//_hPad = createVehicle ["Land_HelipadEmpty_F", _flatPos, [], 0, "NONE"];


if (_distance1 < 900 || _distance2 < 900) then {
	hint "Please choose another location, you have selected a location too close to the AO";
}
else {
	if (_flatPos select 0 == 0) then {
		hint "Couldnt find a good LZ near your point, please select another.  Try to choose somewhere that is less built up";
	}
	else {

		if (isNil "FirstTakeOffHappend") then {
			FirstTakeOffHappend = false;
			publicVariable "FirstTakeOffHappend";
		};

		if (!FirstTakeOffHappend) then {
			[[HQMan,"takeoff"],"sideRadio",true,true] call BIS_fnc_MP;
			FirstTakeOffHappend = true;
			publicVariable "FirstTakeOffHappend";
		};

		//remove the two temp shapes;
		deleteMarker "mrkTempAO1";
		deleteMarker "mrkTempAO2";
		deleteMarker "customLZ1";

		_mrkcustomLZ1 = createMarker ["customLZ1", _flatPos]; 
		_mrkcustomLZ1 setMarkerShape "ICON";
		_mrkcustomLZ1 setMarkerSize [1,1];
		_mrkcustomLZ1 setMarkerColor "ColorBlue";
		_mrkcustomLZ1 setMarkerType "mil_end";
		_mrkcustomLZ1 setMarkerText "LZ";

		_heliPad = "Land_HelipadEmpty_F" createVehicle _flatPos;

		chopper1Landing = false; 
		publicVariable "chopper1Landing";

		//hint (format ["Total Units: %1", _first_parameter]);

		while {(count (waypoints group chopper1D)) > 0} do {
			deleteWaypoint ((waypoints group chopper1D) select 0);
		};

		_flyToLZ = group chopper1D addWaypoint [_flatPos,0,0];
		//_flyToLZ = group chopper1D addWaypoint [_possitionParam,0,0];
		_flyToLZ setWaypointType "MOVE";
		_flyToLZ setWaypointSpeed "FULL";
		_flyToLZ setWaypointBehaviour "CARELESS";
		_flyToLZ setWaypointCombatMode "BLUE";
		_flyToLZ setWaypointStatements ["true", "(vehicle this) LAND 'LAND'; chopper1Landing = true; publicVariable ""chopper1Landing"""];
		//heliPad1

		hint "off we go";

		waitUntil {chopper1Landing && (isTouchingGround chopper1 || {!canMove chopper1})};

		while {(count (waypoints group chopper1D)) > 0} do {
			deleteWaypoint ((waypoints group chopper1D) select 0);
		};

		hint "Destination reached!";

		
		deleteVehicle _heliPad;

		sleep 5;

		savegame;


		//[getPos chopper1] nearObjects ["EmptyDetector", 1000];

		bPlayerOutOfLZChopper = false; 
		publicVariable "bPlayerOutOfLZChopper";

		//CREATE TRIGGER
		_trgLandedAtLZ = createTrigger ["EmptyDetector", getPos chopper1];
		_trgLandedAtLZ setTriggerArea [10, 10, 0, false];
		_trgLandedAtLZ setTriggerActivation ["WEST", "PRESENT", false];
		_trgLandedAtLZ setTriggerStatements ["count thisList > 0", "hint ""Good luck guys!""; bPlayerOutOfLZChopper = true; publicVariable ""bPlayerOutOfLZChopper"";", ""];
		_trgLandedAtLZ setTriggerTimeout [0, 0, 0, true];

		//waitUntil {bPlayerOutOfLZChopper};

		_trgLandedAtLZ2 = createTrigger ["EmptyDetector", getPos chopper1];
		_trgLandedAtLZ2 setTriggerArea [20, 20, 0, false];
		_trgLandedAtLZ2 setTriggerActivation ["WEST", "PRESENT", false];
		_trgLandedAtLZ2 setTriggerStatements ["count thisList == 0 && bPlayerOutOfLZChopper", "nul = [this] execVM ""RandFramework\FlyToBase.sqf""; hint ""Pegasus 1-1 is RTB""", ""];
		_trgLandedAtLZ2 setTriggerTimeout [0, 0, 0, true];

		bPlayerOutOfLZChopper = false; 
		publicVariable "bPlayerOutOfLZChopper";
	};
};
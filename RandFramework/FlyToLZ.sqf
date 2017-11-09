_fnc_dirToText = {
	params [
			["_direction",-1,[0]],  // direction 0 to 360
			["_words",false,[false]] // use word style instead of acronyms
		];

	if (_direction < 0 ||_direction > 360) then {
		"";
	};
	
	_val = round(_direction/45);
	if (_words) then {
		switch(_val) do {
			case 8;
			case 0: {"North"};
			case 1: {"North East"};
			case 2: {"East"};
			case 3: {"South East"};
			case 4: {"South"};
			case 5: {"South West"};
			case 6: {"West"};
			case 7: {"North West"};
		};
	} else {
		switch(_val) do {
			case 8;
			case 0: {"N"};
			case 1: {"NE"};
			case 2: {"E"};
			case 3: {"SE"};
			case 4: {"S"};
			case 5: {"SW"};
			case 6: {"W"};
			case 7: {"NW"};
		};
	};
};

_fnc_getLocationName = {
	params["_position"];

	_location = (nearestLocations [ _position, [ "NameVillage", "NameCity","NameCityCapital","NameMarine","Hill"],5000,_position]) select 0; 
	_locationName =  text (_location);
	_locationPosition = position _location;

	_text = "";
	if (_position distance2D _locationPosition > 1000) then {
		_relDir = _locationPosition getDir _position;
		_text = format ["%1 of %2",[_relDir,true] call _fnc_dirToText,_locationName];
	} else {
		_text = format ["at %1",_locationName];
	};
	_text;
};

_fnc_callOutLiftoffAtLZ = {
	params ["_group","_vehicle"];
	_locationText = [position _vehicle] call _fnc_getLocationName;
	_text = format ["%1 is entering airspace %2 - We're RTB.", groupId _group, _locationText];
	[_vehicle,_text] remoteExecCall ["sideChat",driver _vehicle,false];
};

_fnc_callOutTakeoff = {
	params ["_group","_vehicle"];
	_locationText = [position _vehicle] call _fnc_getLocationName;
	_text = format ["%1 you are cleared for take off %2.", groupId _group,_locationText];
	[HQMan,_text] remoteExecCall ["sideChat",HQMan,false];
};


/* 	Script starting here  */
params ["_destinationPosition","_vehicle"];

_distance1 = getMarkerPos "mrkFirstLocation" distance _destinationPosition;
_distance2 = getMarkerPos "mrkSecondLocation" distance _destinationPosition;

_safeLandingZonePosition = nil;
_safeLandingZonePosition = [_destinationPosition , 0, 150, 4, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;


if (_distance1 < 900 || _distance2 < 900) then {
	hint "Please choose another location, you have selected a location too close to the AO";
} else {
	if (_safeLandingZonePosition select 0 == 0) then {
		hint "Couldnt find a good LZ near your point, please select another.  Try to choose somewhere that is less built up";
	} else {
		
		// set base LZ for the way back.
		if (isNull (_vehicle getVariable "baseLZ")) then {
			_vehicle setVariable ["baseLZ", position _vehicle, true];
		};

		_driver = driver _vehicle;

		if (isNil "FirstTakeOffHappend") then {
			FirstTakeOffHappend = false;
			publicVariable "FirstTakeOffHappend";
		};

		if (!FirstTakeOffHappend) then {
			[group _driver, _vehicle] call _fnc_callOutTakeoff; // use spaw once function is global
		
			FirstTakeOffHappend = true;
			publicVariable "FirstTakeOffHappend";
		};

		//remove the two temp shapes;
		deleteMarker "mrkTempAO1";
		deleteMarker "mrkTempAO2";
		deleteMarker "customLZ1";

		_mrkcustomLZ1 = createMarker ["customLZ1", _safeLandingZonePosition]; 
		_mrkcustomLZ1 setMarkerShape "ICON";
		_mrkcustomLZ1 setMarkerSize [1,1];
		_mrkcustomLZ1 setMarkerColor "ColorBlue";
		_mrkcustomLZ1 setMarkerType "hd_pickup";
		_mrkcustomLZ1 setMarkerText "LZ";

		_heliPad = "Land_HelipadEmpty_F" createVehicle _safeLandingZonePosition;

		chopper1Landing = false; 
		publicVariable "chopper1Landing";

		//hint (format ["Total Units: %1", _first_parameter]);

		{
			deleteWaypoint _x
		} foreach waypoints group _driver;

		_flyToLZ = group _driver addWaypoint [_safeLandingZonePosition,0,0];
		_flyToLZ setWaypointType "MOVE";
		_flyToLZ setWaypointSpeed "FULL";
		_flyToLZ setWaypointBehaviour "CARELESS";
		_flyToLZ setWaypointCombatMode "BLUE";
		_flyToLZ setWaypointStatements ["true", "(vehicle this) LAND 'LAND'; chopper1Landing = true; publicVariable ""chopper1Landing"""];
		//heliPad1

		waitUntil {isEngineOn _vehicle};
		sleep 3;
		[_vehicle,"Off we go."] remoteExec ["vehicleChat",driver _vehicle,false];
		_vehicle flyInHeight 40;

		waitUntil {chopper1Landing && (isTouchingGround _vehicle || {!canMove _vehicle})};

		{
			deleteWaypoint _x
		} foreach waypoints _driver;

		sleep 3;

		[_vehicle,"We reached our destination. Good Luck out there!"] remoteExecCall ["vehicleChat",driver _vehicle,false];
		
		deleteVehicle _heliPad;

		sleep 5;

		if (!isMultiplayer) then {
			savegame;
		};

		_driverGroup = group _driver;
		waitUntil { { alive _x && group _x != _driverGroup; } count (crew _vehicle) == 0; };

		[_driverGroup,_vehicle] call _fnc_callOutLiftoffAtLZ; // use spaw once function is global

		[_vehicle] execVM "RandFramework\FlyToBase.sqf"
	};
};
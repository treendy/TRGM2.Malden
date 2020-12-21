params [
	"_side",
	"_vehicles",
	"_startPos",
	"_endPos",
	["_hvtUnitClass", ""],
	["_hvtVehClass", ""],
	["_guardUnitClasses", []],
	["_wpPosArray", []]
];

_finalGroup = [];
_group = creategroup _side;
_group setFormation "FILE";
_group setSpeedMode "LIMITED";

_dir = [_startPos, _endPos] call BIS_fnc_dirTo;
_pos = _startPos;
{
	_vehicleClass = _x;
	if (!isNil "_vehicleClass") then {
		_pos = [_pos, 0, 50, 10, 0, 0.5, 0, [], [_pos,_pos], _vehicleClass] call TREND_fnc_findSafePos;
		_vehicle = _vehicleClass createvehicle _pos;
		_vehicle allowDamage false;
		_vehicle setDir _dir;
		createvehiclecrew _vehicle;
		_crew = crew _vehicle;
		_crew joinsilent _group;
		_group addVehicle _vehicle;
		{
			_x setVariable ["zbe_cacheDisabled", true, true];
		} forEach crew _vehicle;
		if (_forEachIndex == 0) then {
			_group selectLeader (commander _vehicle);
		};
		_group setFormation "FILE";
		_vehicle lockdriver true;
		_pos = _vehicle modelToWorld [0,-25,0];
		_finalGroup pushBack _vehicle;
	};
} forEach _vehicles;

_hvtVehicle = objNull;
_hvtUnit = objNull;
if !(_hvtUnitClass isEqualTo "") then {
	_hvtVehicle = _finalGroup select floor ((count _finalGroup)/2); // Middle vehicle works for an HVT, additional options later?

	if !(_hvtVehClass isEqualTo "") then { // Does HVT get a special vehicle?
		_index = _finalGroup find _hvtVehicle;
		_pos = getpos _hvtVehicle;
		_dir = getdir _hvtVehicle;
		_driverClass = typeOf(driver _hvtVehicle);

		{deleteVehicle _x} forEach (crew _hvtVehicle) + [_hvtVehicle];

		_hvtVehicleNew = _hvtVehClass createVehicle ([_startPos, 0, 50, 10, 0, 0.5, 0, [], [_startPos,_startPos], _hvtVehClass] call TREND_fnc_findSafePos);
		_hvtVehicleNew allowDamage false;
		_hvtVehicle = _hvtVehicleNew;
		_hvtVehicle setpos _pos;
		_hvtVehicle setdir _dir;
		_finalGroup set [_index,_hvtVehicle];

		_driver = _group createUnit [_driverClass, [_startPos select 0, _startPos select 1, 0], [], 0, "NONE"];
		_driver setVariable ["zbe_cacheDisabled", true, true];
		_driver assignAsDriver _hvtVehicle;
		_driver moveInDriver _hvtVehicle;
	};

	_group = group driver _hvtVehicle;

	if !(_guardUnitClasses isEqualTo []) then {
		{
			if ((_hvtVehicle emptyPositions "Cargo") > 1) then {
				_guardUnit = _group createUnit [_x, [_startPos select 0, _startPos select 1, 0], [], 0, "NONE"];
				_guardUnit setVariable ["zbe_cacheDisabled", true, true];
				_guardUnit assignAsCargo _hvtVehicle;
				_guardUnit moveInCargo _hvtVehicle;
			} else {
				if ((_hvtVehicle emptyPositions "Cargo") isEqualTo 1) exitWith {};
			};
		} forEach _guardUnitClasses;
	};

	_hvtUnit = _group createUnit [_hvtUnitClass, [_startPos select 0, _startPos select 1, 0], [], 0, "NONE"];
	_hvtUnit setVariable ["zbe_cacheDisabled", true, true];
	_hvtUnit setCaptive true;
	removeAllWeapons _hvtUnit;
	_hvtUnit assignAsCargo _hvtVehicle;
	_hvtUnit moveInCargo _hvtVehicle;
};

{
	if !(_x isEqualTo _hvtVehicle) then {
		_thisVehicle = _x;
		for [{private _i = 0}, {_i < (_thisVehicle emptyPositions "NONE")}, {_i = _i + 1}] do {
			_unitTypeIndex = [_i, 8] select (_i > 8);
			_convoyUnit = _group createUnit [[call sTeamleader, call sMachineGunMan, call sATMan, call sMedic, call sAAMan, call sEngineer, call sGrenadier, call sSniper, call sRifleman] select _unitTypeIndex, [getPos _thisVehicle select 0, getPos _thisVehicle select 1 + 5, 0], [], 0, "NONE"];
			_convoyUnit setVariable ["zbe_cacheDisabled", true, true];
			_convoyUnit assignAsCargo _thisVehicle;
			_convoyUnit moveInCargo _thisVehicle;
		};
	};
} forEach _finalGroup;

if !(_wpPosArray isEqualTo []) then {
	{
		_aslPos = [_x select 0, _x select 1, getTerrainHeightASL [_x select 0, _x select 1]];
		_aglPos = ASLToAGL _aslPos;
		private _wp = _group addWaypoint [_aglPos, 25];
		_wp setWaypointType "MOVE";
		_wp setWaypointCompletionRadius 25;
		_wp setwaypointCombatMode "GREEN";
		_wp setWaypointFormation "FILE";
		_wp setWaypointBehaviour "SAFE";
	} forEach _wpPosArray;
};

_aslPos = [_endPos select 0, _endPos select 1, getTerrainHeightASL [_endPos select 0, _endPos select 1]];
_aglPos = ASLToAGL _aslPos;
private _finalwp = _group addWaypoint [_aglPos, 25];
_finalwp setWaypointType "GETOUT";
_finalwp setWaypointCompletionRadius 25;
_finalwp setwaypointCombatMode "GREEN";
_finalwp setWaypointFormation "FILE";
_finalwp setWaypointBehaviour "SAFE";

{
	_unit = _x;
	_unit setVariable ["zbe_cacheDisabled", true, true];
	if (vehicle _unit == _unit) then {
		{
			if (_x emptyPositions "CARGO" > 0) exitWith {
				_unit assignAsCargo _x;
				_unit moveInCargo _x;
			};
		} forEach (_finalGroup - [_hvtVehicle]);
	};
} forEach units _group;

{
	_x allowDamage true;
} forEach _finalGroup;

[_group, 50, 20, true] spawn TREND_fnc_convoy;

[_group, _finalGroup, _hvtVehicle, _hvtUnit, _finalwp];
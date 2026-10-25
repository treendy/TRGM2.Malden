//Reads the "OtherObjects:" section of the loadout data and swaps the editor placed base vehicles / unit type arrays for the ones set there
if (isNil "LoadoutData") then {LoadoutData = ""};
if (isNil "LoadoutDataDefault") then {LoadoutDataDefault = ""};
if (LoadoutData == "" && LoadoutDataDefault == "") exitWith {};

private _MergedLoudoutData = LoadoutData + "#" + LoadoutDataDefault;
private _tempAddedObjects = [];

private _chrLineBreak = "
"; // <<< no idea how to find the ascii or char value that i can use to split a string on line breaks... this works for now
private _chrTab = "	";
private _whiteSpace = " " + _chrLineBreak + _chrTab;

//Replaces the editor placed vehicle stored in the global var _varName with a new vehicle of _class
private _fnc_replaceVehicle = {
	params ["_varName","_class",["_withCrew",false]];
	private _oldVeh = missionNamespace getVariable [_varName, objNull];
	if (isNull _oldVeh) exitWith {objNull};
	private _pos = getPosATL _oldVeh;
	private _dir = getDir _oldVeh;
	{deleteVehicle _x;} forEach crew _oldVeh;
	deleteVehicle _oldVeh;
	sleep 0.01;
	private _newVeh = createVehicle [_class, _pos, [], 0, "CAN_COLLIDE"];
	_newVeh setDir _dir;
	_newVeh allowDamage false;
	_newVeh setPos (_pos vectorAdd [0,0,0.1]);
	if (_withCrew) then {createVehicleCrew _newVeh;};
	_newVeh setVehicleVarName _varName;
	missionNamespace setVariable [_varName, _newVeh, true];
	_newVeh
};

//object name in loadout data => editor vehicle var names that get replaced
private _vehicleReplacements = [
	["AirSupport1",["airSup1"]],
	["AirSupport2",["airSup2"]],
	["ArmoredCar",["car1"]],
	["TankorAPC",["tank1"]],
	["UnarmedCar",["k1car2"]],
	["MedicalTruck",["medTruck"]],
	["MedicalChopper",["mediChop1"]],
	["LargeTransportChopper",["chin1"]],
	["FuelTruck",["Fuel1","Fuel2"]],
	["RepairTruck",["RepairTruck"]],
	["AmmoTruck",["AmmoTruck"]],
	["SmallHeli",["SmallHeli1","SmallHeli2","SmallHeli3"]]
];
//these also store the class name in a global var of the same name
private _storeClassName = ["ArmoredCar","TankorAPC","UnarmedCar","MedicalTruck","FuelTruck"];
//these are just stored in a global var of the same name
private _globalArrays = ["FriendlyScoutVehicles","FriendlyCheckpointUnits","FriendlyFastResponseVehicles","FriendlyVictims","FriendlyVictimVehs","Paramedics","Ambulances","AirAmbulances","Police","PoliceVehicles","Reporters","ReporterChoppers","FriendlyUnarmedCar","FriendlyMedicalTruck","FriendlyArmoredCar","FriendlyFuelTruck","FriendlyJet","FriendlyChopper"];
//support modules that use the vehicle list
private _supportModules = [
	["SupplySupportChopperOptions",{supReqSupDrop}],
	["AirSupportOptions",{supReqAirSup}],
	["ArtiSupportOptions",{SupProArti}]
];

private _replacedVehicles = [];
{
	private _RoleDetails = _x splitString ":";
	private _roleType = (_RoleDetails select 0) splitString _whiteSpace joinString "";
	if (_roleType == "OtherObjects") then {
		private _loadoutoptions = (_RoleDetails select 1) splitString ";";
		{
			private _line = _x splitString "=";
			private _name = _line select 0;
			private _object = _line select 1;
			if (!isNil "_name" && !isNil "_object") then {
				_name = _name splitString _whiteSpace joinString "";
				_object = _object splitString _whiteSpace joinString "";
				if ("[" in (_object splitString "")) then { //convert to array
					_object = (_object splitString """[]" joinString "") splitString ",";
				};
				if (!(_name in _tempAddedObjects)) then {
					_tempAddedObjects pushBack _name;

					private _replaceIndex = _vehicleReplacements findIf {_x select 0 == _name};
					if (_replaceIndex > -1) then {
						{
							_replacedVehicles pushBack ([_x, _object] call _fnc_replaceVehicle);
						} forEach ((_vehicleReplacements select _replaceIndex) select 1);
						if (_name in _storeClassName) then {
							missionNamespace setVariable [_name, _object];
						};
					};

					if (_name == "AITransportChopper") then {
						private _chopper = ["chopper1", _object, true] call _fnc_replaceVehicle;
						if (!isNull _chopper) then {
							_chopper setCaptive true;
							_chopper disableAI "AUTOTARGET";
							_chopper disableAI "TARGET";
							_chopper disableAI "SUPPRESSION";
							_chopper disableAI "AUTOCOMBAT";
							_chopper setBehaviour "SAFE";
						};
					};
					if (_name == "AIExtractSupuportChopper") then {
						["chopper2", _object, true] call _fnc_replaceVehicle;
					};

					if (_name in _globalArrays) then {
						missionNamespace setVariable [_name, _object];
					};

					private _supportIndex = _supportModules findIf {_x select 0 == _name};
					if (_supportIndex > -1) then {
						missionNamespace setVariable [_name, _object];
						(call ((_supportModules select _supportIndex) select 1)) setVariable ['BIS_SUPP_vehicles',_object,true];
					};
				};
			};
		} forEach _loadoutoptions;
	};
} forEach (_MergedLoudoutData splitString "#");

//base vehicles are spawned without damage so they don't blow up while being placed, re-enable it after a while
[_replacedVehicles] spawn {
	params ["_replacedVehicles"];
	sleep 30;
	{
		if (!isNull _x) then {_x allowDamage true;};
	} forEach _replacedVehicles;
};

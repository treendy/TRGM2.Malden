// // // // // // // // // // // // // // // // // // // // // // // // // // // // //
// Aux SlingLoading Script
// Version 1.14
// Date: 2015.05.01
// Authors: Lala14
// // // // // // // // // // // // // // // // // // // // // // // // // // // // //

// init line:
// null = [] execVM "auxslingloading.sqf";

/*DEFINABLE*/
if (isNil "AuxSling_Weight") then {
AuxSling_Weight = 1; //Does the sling weight matter? If 0 this means a LittleBird can Lift a tank, If 1 then no
};
if (isNil "AuxSling_slingSlingableVehicles") then {
AuxSling_slingSlingableVehicles = 0; //Include vehicles that can be sling loaded with the chopper. e.g. Huron can lift Offroad, you can use this script if set to 1 to
};
if (isNil "AuxSling_EveryVehicles") then {
AuxSling_EveryVehicles = 0; //If AuxSling_Weight = 1, Allow for EVERY VEHICLE/OBJECT to be lifted, ignores AuxSling_x_config
};
if (isNil "AuxSling_indestructibleLoad") then {
AuxSling_indestructibleLoad = 1; //If AuxSling_indestructibleLoad = 1, The sling load will become indestructible while being slinged until no longer being slinged
};
if (isNil "AuxSling_allowDeadCarry") then {
AuxSling_allowDeadCarry = 1; //if AuxSling_allowDeadCarry = 1, Allowed to sling dead vehicles
};
/*Don't touch unless you know what your doing*/
AuxSling_Loaded = false;

if (isDedicated) exitWith {
	if (isNil "AuxSling_globalVar") then {
		AuxSling_globalVar = 'init';
		"AuxSling_globalVar" addPublicVariableEventHandler {
			/*systemChat str (_this select 0);
			systemChat str (_this select 1);
			_array = ((_this select 1) select 0);
			_stuff = ((_this select 1) select 1);
			_isspawn = ((_this select 1) select 2);
			if (isNil "_isspawn") then { _isspawn = false; };
			if (typeName _stuff isEqualTo "STRING") then { _stuff = call compile _stuff; };
			if (_isspawn) then { _array spawn _stuff } else { _array call _stuff };*/
			[] spawn AuxSling_fnc_localGlobalExec;
		};
	};
};

diag_log "AuxSling Loading";

waitUntil {!isNull player};

if (isNil "AuxSling_globalVar") then {
	if (isNil "AuxSling_globalVar") then {
		AuxSling_globalVar = 'init';
		"AuxSling_globalVar" addPublicVariableEventHandler {
			[] spawn AuxSling_fnc_localGlobalExec;
		};
	};
};

// config [["kindOf classnames"] ]]
if (isNil "AuxSling_light_config") then { AuxSling_light_config = [] };
if (isNil "AuxSling_medium_config") then { AuxSling_medium_config = [] };
if (isNil "AuxSling_heavy_config") then { AuxSling_heavy_config = [] };

AuxSling_light_config = AuxSling_light_config + ["Offroad_01_base_F","Hatchback_01_base_F","SUV_01_base_F"]; //lift = 500 e.g. Littlebird
AuxSling_medium_config = AuxSling_light_config + AuxSling_medium_config + ["APC_Wheeled_01_base_F","APC_Wheeled_02_base_F","APC_Wheeled_03_base_F","Cha_LAV25_base"]; //lift = 4000 e.g GhostHawk
AuxSling_heavy_config = AuxSling_medium_config + AuxSling_heavy_config + ["APC_Tracked_01_base_F","APC_Tracked_02_base_F","APC_Tracked_03_base_F","MBT_01_base_F","MBT_02_base_F","MBT_03_base_F","Truck_01_base_F","Truck_02_base_F","Truck_03_base_F","Plane_CAS_01_base_F","Plane_CAS_02_base_F","Plane_Fighter_03_base_F"]; //lift = 10000 e.g. Huron

AuxSling_fnc_InList = {
	_found = false;
	_object = objNull;
	_list = "AuxSling_light_config";
	_objectsfound = _this select 0;
	_vehweight = [_this, 1, 10000] call bis_fnc_param;

	{
		_obj = _x;

		if (_vehweight >= 0 && !_found) then {
			{
				if (_obj isKindOf _x) exitWith {_found = true; _list = "AuxSling_light_config";};
			}forEach AuxSling_light_config;
		};
		if (_vehweight > 600 && !_found) then {
			{
				if (_obj isKindOf _x) exitWith {_found = true; _list = "AuxSling_medium_config";};
			}forEach AuxSling_medium_config;
		};
		if (_vehweight > 4000 && !_found) then {
			{
				if (_obj isKindOf _x) exitWith {_found = true; _list = "AuxSling_heavy_config";};
			}forEach AuxSling_heavy_config;
		};
		if (_found) exitWith {_object = _x;};
	}forEach _objectsfound;
	if ((AuxSling_Weight == 0) && (AuxSling_EveryVehicles == 1)) then {_object = _objectsfound select 0};
	[_object,_list];
};

AuxSling_fnc_DoAttaching = {
	_unit = _this select 0;
	_veh = vehicle _unit;
	_vehweight = getNumber (configfile >> "CfgVehicles" >> typeOf _veh >> "slingLoadMaxCargoMass");
	if (AuxSling_Weight == 0) then {_vehweight = 10000;};
	if (!isNil {_veh getVariable "AuxSling_AttachedObject"}) exitWith {hint (localize "STR_TRGM2_auxslingloading_Attached")};
	_nearUnits = nearestObjects [_veh, ["Ship","LandVehicle","Air"],11];
	_nearUnits = _nearUnits - [_veh];
	if (count _nearUnits == 0) exitWith {hint (localize "STR_TRGM2_auxslingloading_NoNear")};
	_obj = objNull;
	_ropecount = [];

	_returnofthedead = [_nearUnits,_vehweight] call AuxSling_fnc_InList;
	_obj = _returnofthedead select 0;
	_list = _returnofthedead select 1;
	if ((isNull _obj) && (AuxSling_EveryVehicles == 0)) exitWith {hint (localize "STR_TRGM2_auxslingloading_NoValid")};
	if ((AuxSling_allowDeadCarry == 0) && !(alive _obj)) exitWith {hint (localize "STR_TRGM2_auxslingloading_CantCarry")};

	if (count getArray (configfile >> "CfgVehicles" >> typeof _obj >> "slingLoadCargoMemoryPoints") > 0) then {
		_ropecount = getArray (configfile >> "CfgVehicles" >> typeof _obj >> "slingLoadCargoMemoryPoints");
	};
	if ((AuxSling_Weight == 0) && (AuxSling_EveryVehicles == 1)) exitWith { [_unit,_obj,_ropecount,"I_Quadbike_01_F"] spawn AuxSling_fnc_TheAttaching; };
	if (AuxSling_Weight == 0) exitWith { [_unit,_obj,_ropecount,"I_Quadbike_01_F"] spawn AuxSling_fnc_TheAttaching; };
	if (_list isEqualTo "AuxSling_heavy_config") then {
		[_unit,_obj,_ropecount,"B_MRAP_01_F"] spawn AuxSling_fnc_TheAttaching;
	};
	if (_list isEqualTo "AuxSling_medium_config") then {
		[_unit,_obj,_ropecount,"C_Hatchback_01_F"] spawn AuxSling_fnc_TheAttaching;
	};
	if (_list isEqualTo "AuxSling_light_config") then {
		[_unit,_obj,_ropecount,"I_Quadbike_01_F"] spawn AuxSling_fnc_TheAttaching;
	};
};

AuxSling_fnc_TheAttaching = {
	_unit = _this select 0;
	_veh = vehicle _unit;
	_obj = _this select 1;
	if (AuxSling_indestructibleLoad == 1) then {
		_theowner = owner _obj;
		if ((isMultiplayer) && (_theowner isEqualTo 0) && !(local _obj)) then {
			[[_obj],{(_this select 0) allowDamage false;},true] spawn AuxSling_fnc_execGlobal;
		} else {
			_obj allowDamage false;
		};
	};
	_ropecount = _this select 2;
	_oneropeveh = _this select 3;
	if (count _ropecount > 0) then {
		_veh setVariable ["AuxSling_Ropes",[],true];
		_veh setVariable ["AuxSling_AttachedToPoints",[],true];

		_ball = createVehicle [_oneropeveh, getposatl _obj, [], 0, "CAN_COLLIDE"];
		_ball allowDamage false;
		_ball setDir (getDir _obj);
		_ball setVariable ["BIS_enableRandomization",false,true];
		_obj attachto [_ball];
		///{_ball setObjectTextureGlobal [_forEachIndex,''];}forEach (getArray (configFile >> 'cfgVehicles' >> typeOf _ball >> "hiddenSelections"));
		_ball hideObjectGlobal true;
		_ball enableSimulationGlobal true;
		_initialRope = ropeCreate [_veh, "slingload0", _ball, [0,0,0], 10];
		_veh setVariable ["AuxSling_Ropes",(_veh getVariable "AuxSling_Ropes") + [_initialRope],true];
		_veh setVariable ["AuxSling_AttachedToPoints",(_veh getVariable "AuxSling_AttachedToPoints") + [_ball],true];
		{
			//_ropename = ropeCreate [_veh, "slingload0", _obj, _x, 10];
			_test = "Sign_Sphere10cm_F" createVehicle getPos _obj;
			_test attachto [_obj,[0,0,0],_x];
			_ropename = ropeCreate [_veh, "slingload0", _test, [0,0,0], 10];
			{_test setObjectTextureGlobal [_forEachIndex,''];}forEach (getArray (configFile >> 'cfgVehicles' >> typeOf _test >> "hiddenSelections"));
			_veh setVariable ["AuxSling_Ropes",(_veh getVariable "AuxSling_Ropes") + [_ropename],true];
		}forEach _ropecount;
		_veh setVariable ["AuxSling_AttachedObject",_obj,true];
	} else {
			_ball = createVehicle [_oneropeveh, getposatl _obj, [], 0, "CAN_COLLIDE"];
			_ball allowDamage false;
			_ball setDir (getDir _obj);
			_ball setVariable ["BIS_enableRandomization",false,true];
			_obj attachTo [_ball];
			for "_i" from 0 to count (getArray (configfile >> "CfgVehicles" >> _oneropeveh >> "hiddenSelections")) do {
				_ball setObjectTextureGlobal [_i,""];
			};
			_ropename = ropeCreate [_veh, "slingload0", _ball, [0,0,0], 10];
			_veh setVariable ["AuxSling_AttachedObject",_obj,true];
			_veh setVariable ["AuxSling_Ropes",[_ropename],true];
			_veh setVariable ["AuxSling_AttachedToPoints",[_ball],true];
	};
	_veh enableRopeAttach false;
	[_unit,_obj] spawn AuxSling_fnc_DetectParentDestroyed;
};

AuxSling_fnc_DoDetaching = {
	_unit = _this select 0;
	_veh = vehicle _unit;
	_obj = _this select 1;
	if (isNil "_obj") then { _obj = (_veh getVariable "AuxSling_AttachedObject"); } else { if (!(_obj in (attachedObjects _veh)) && (alive _veh)) then { _obj = nil; }; };
	if (isNil "_obj") exitWith {};
	_attachedropes = _veh getVariable "AuxSling_Ropes";
	_attachedpoints = _veh getVariable "AuxSling_AttachedToPoints";
	_curvel = velocity (_veh getVariable "AuxSling_AttachedObject");
	if (isNil "_curvel") then { _curvel = [0,0,0]; };

	{
		deleteVehicle _x;
	}forEach _attachedpoints;
	_veh setVariable ["AuxSling_AttachedToPoints",nil,true];

	{
		ropeDestroy _x;
	}forEach _attachedropes;
	_veh setVariable ["AuxSling_Ropes",nil,true];
	_theowner = owner _obj;
	if ((isMultiplayer) && (_theowner isEqualTo 0) && !(local _obj)) then {
		[[_obj],{(_this select 0) allowDamage true;},true] spawn AuxSling_fnc_execGlobal;
	} else {
		_obj allowDamage false;
	};
	(_veh getVariable "AuxSling_AttachedObject") setVelocity _curvel;
	_veh setVariable ["AuxSling_AttachedObject",nil,true];
	_veh enableRopeAttach true;
};

AuxSling_fnc_DetectParentDestroyed = {
	_unit = _this select 0;
	_veh = vehicle _unit;
	_obj = _this select 1;
	waitUntil { if (!alive _veh) then { [_unit,_obj] spawn AuxSling_fnc_DoDetaching; _veh setVariable ["AuxSling_AttachedObject",nil,true]; }; if (!(alive _obj) && (AuxSling_allowDeadCarry == 0)) then { [_unit,_obj] spawn AuxSling_fnc_DoDetaching; _veh setVariable ["AuxSling_AttachedObject",nil,true]; }; (isNull (_veh getVariable ["AuxSling_AttachedObject",objNull])) };
};

AuxSling_fnc_execGlobal = {
	AuxSling_globalVar = _this;
	[] spawn AuxSling_fnc_localGlobalExec;
	publicVariable "AuxSling_globalVar";
};

AuxSling_fnc_localGlobalExec = {
	private ["_mainarr","_array","_stuff","_isspawn"];
	_mainarr = ['AuxSling_globalVar',AuxSling_globalVar];
	//systemChat str (_mainarr select 0);
	//systemChat str (_mainarr select 1);
	_array = ((_mainarr select 1) select 0);
	_stuff = ((_mainarr select 1) select 1);
	_isspawn = ((_mainarr select 1) select 2);
	if (isNil "_isspawn") then { _isspawn = false; };
	if (typeName _stuff isEqualTo "STRING") then { _stuff = call compile _stuff; };
	if (_isspawn) then { _array spawn _stuff } else { _array call _stuff };
};

AuxSling_fnc_Conditions1 = {
	_unit = _this select 0;
	_veh = _this select 1;

	_nearUnits = nearestObjects [_veh, ["Car","Motorcycle","Tank","Ship","Autonomous","Air"],11];
	_nearUnits = _nearUnits - [_veh];

	_vehweight = getNumber (configfile >> "CfgVehicles" >> typeOf _veh >> "slingLoadMaxCargoMass");
	if (AuxSling_Weight == 0) then {_vehweight = 10000;};
	_returnofthedead = [_nearUnits,_vehweight] call AuxSling_fnc_InList;
	_obj = _returnofthedead select 0;
	_list = _returnofthedead select 1;

	if !(isNull _obj) then {
		_vehname = format [localize "STR_TRGM2_auxslingloading_SlingLoad",getText (configfile >> "CfgVehicles" >> typeOf _obj >> "displayName")];
		_unit setUserActionText [(_unit getVariable "AuxSling_Load_Action"),_vehname];
	} else {
		_unit setUserActionText [(_unit getVariable "AuxSling_Load_Action"),localize "STR_TRGM2_auxslingloading_UnableToSling"];
	};
	_return = (alive _veh) && ((isNil {_veh getVariable "AuxSling_AttachedObject"}) && (count _nearUnits > 0) && (_veh isKindOf "Helicopter"));
	if (AuxSling_slingSlingableVehicles == 0) then { _return = _return && !(_veh canSlingLoad _obj); };
	if ((AuxSling_allowDeadCarry == 0) && (!alive _obj) ) then {
		_unit setUserActionText [(_unit getVariable "AuxSling_Load_Action"),localize "STR_TRGM2_auxslingloading_UnableToSling"];
	};

	_return;
};


AuxSling_fnc_Conditions2 = {
	_unit = _this select 0;
	_veh = _this select 1;

	_vehname = format [localize "STR_TRGM2_auxslingloading_Detach",getText (configfile >> "CfgVehicles" >> typeOf (_veh getVariable "AuxSling_AttachedObject") >> "displayName")];
	_unit setUserActionText [AuxSling_unLoad_Action,_vehname];

	_return = (!(isNil {_veh getVariable "AuxSling_AttachedObject"}));

	_return;
};

AuxSling_fnc_AddAction = {
	_unit = _this select 0;
	if (isNil {_unit getVariable "AuxSling_Added"}) then {
		AuxSling_Load_Action = _unit addAction [localize "STR_TRGM2_auxslingloading_SlingLoad",{[(_this select 0)] spawn AuxSling_fnc_DoAttaching},"",-99,true,true,"",'[_this,_target] call AuxSling_fnc_Conditions1'];
		_unit setVariable ["AuxSling_Load_Action",AuxSling_Load_Action,true];
		AuxSling_unLoad_Action = _unit addAction [localize "STR_TRGM2_auxslingloading_DetachLoad",{[(_this select 0)] spawn AuxSling_fnc_DoDetaching},"",-99,false,true,"",'[_this,_target] call AuxSling_fnc_Conditions2'];
		_unit setVariable ["AuxSling_unLoad_Action",AuxSling_unLoad_Action,true];
		_unit setVariable ["AuxSling_Added",true,true];
	};
};

[player] spawn AuxSling_fnc_AddAction;
player addEventHandler ["Respawn",{
	(_this select 0) setVariable ["AuxSling_Added",nil,true];
	[(_this select 0)] spawn AuxSling_fnc_AddAction;
}];

AuxSling_Loaded = true;
diag_log "AuxSling Loaded";
systemChat (localize "STR_TRGM2_auxslingloading_Init");
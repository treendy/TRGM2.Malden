params ["_vehicles"];

if (!isServer) exitWith {};

/********************* Add Player Actions ****************/

if ([] call TRGM_fnc_isAceLoaded) then {
	//Ace action

	
	_generateChildActions = {
		params ["_target", "_player", "_params"];
		_params params ["_vehicles"];

		diag_log format ["_insertChildren [%1, %2, %3]", _target, _player, _params];


		_actionAdapterPickupAce = {
			diag_log format ["_adapter %1",  _this];
			params ["_target", "_player", "_params"];
			diag_log _this;
			_params params ["_selectedVehicle"];
			diag_log _selectedVehicle;
			[_selectedVehicle,true] spawn TRGM_fnc_selectLZ;
		};

		_childCondition = {

			params ["_target", "_player", "_params"];
			_params params ["_selectedVehicle"];
			alive _selectedVehicle && !(_player in (crew _selectedVehicle));
		};


		// Add children to this action
		private _actions = [];
		{
			
			_actionName = [_x] call TRGM_fnc_getTransportName;
			_action = [format ["vehicle:%1",_x],_actionName, "", _actionAdapterPickupAce, _childCondition , {}, _x] call ace_interact_menu_fnc_createAction;
			_actions pushBack [_action, [], _x]; // New action, it's children, and the action's target
		} forEach _vehicles;
		diag_log format ["actions: %1", _actions];


		_actions;
	};

	_selfAction = [
		'CallTransportChopper',
		localize 'STR_TRGM2_transport_fnaddTransportActionsPlayer_CallTransport',
		'',
		{},
		{true},
		_generateChildActions,
		[_vehicles]
	] call ace_interact_menu_fnc_createAction;

	_code =  { 
		[player, 1, ["ACE_SelfActions"], _this] call ace_interact_menu_fnc_addActionToObject;
	};
	//[_selfAction,_code] remoteExec ["call", [0, -2] select isMultiplayer,true];
	[_selfAction,_code] remoteExec ["call", 0,true];


} else {
	// Fallback vanilla action

	_actionAdapterPickup = {
		params ["_target", "_caller", "_ID", "_arguments"];
		_arguments params ["_targetVehicle"];
		[_targetVehicle,true] spawn TRGM_fnc_selectLZ;
	};

	_playerActions = [];
	{
		// since you can not access arguments within the condition, use a global unique identifier for the argument variable
		// create a unique variableName with prefix
		_uniqueVarName = [_x,"TRGM_transport_vehicle_"] call BIS_fnc_objectVar;
		publicVariable _uniqueVarName;
		_condition = format ["alive %1 && !(_this in (crew %1))",_uniqueVarName];
		
		_name = [_x] call TRGM_fnc_getTransportName;
		_actionName = format [localize "STR_TRGM2_TRGMInitPlayerLocal_CallHeliTransport",_name];

		_playerActions pushBack [
			_actionName,
			_actionAdapterPickup,
			[_x],
			-20, //priority
			false,
			true,
			"",
			_condition,
			-1,
			false,
			""
		];
		
	} forEach _vehicles;
	
	// add actions on player with CBA_fnc_addPlayerAction (respawn persistent)
	{
		//[_x] remoteExec ["TRGM_fnc_addPlayerActionPersistent",[0, -2] select isMultiplayer,true];
		[_x] remoteExec ["TRGM_fnc_addPlayerActionPersistent",0,true];
	}	foreach _playerActions;
};


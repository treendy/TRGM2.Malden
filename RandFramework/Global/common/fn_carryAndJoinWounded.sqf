_civ=_this select 0;
_player=_this select 1;

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

//Add other params here so can pass in rep reward reason (so can use for other events, or for bringing back dead players)

if (alive _civ) then {
	{
	  [_x, "Acts_CivilListening_2"] remoteExec ["switchMove", 0];
	  detach _x;
	} forEach attachedObjects _civ;
	//_civ setUnconscious true;


	_civ disableAI "anim";
	_civ disableAI "MOVE";

/*
	_civ attachTo [_player, [0.5,0,0]];
	_civ setDir 180;
	[_civ] spawn {_this select 0 switchMove ""; [_this select 0, "grabCarried"] remoteExec ["playActionNow", 0, false]};
	sleep 4;
	[_player] spawn {_this select 0 switchMove "AcinPknlMstpSnonWnonDnon_AcinPercMrunSnonWnonDnon"; };
*/
	//_civ switchMove "";
	//sleep 0.1;
	//["AAAAA"] call TRGM_GLOBAL_fnc_notify;
	disableUserInput true;
	_pos = _player ModelToWorld [0,1.8,0];
	_civ setPos _pos;
	//_civ attachTo [_player, [-0.6, 0.28, -0.05]];
	_civ attachTo [_player, [0.5,0,0]];
	[_civ, 180] remoteExec ["setDir", 0, false];
	//_civ attachTo [_player, [0.5,0,0]];
	//_civ setDir 180;
	[_civ] spawn {_this select 0 switchMove ""; [_this select 0, "grabCarried"] remoteExec ["playActionNow", 0, false]};
	sleep 4;
	[_player] spawn {_this select 0 switchMove "AcinPknlMstpSnonWnonDnon_AcinPercMrunSnonWnonDnon"; };

	disableUserInput false;
	disableUserInput true;
	disableUserInput false;

	[_civ,_player] spawn {
		_civ = _this select 0;
		_player = _this select 1;
		_doLoop = true;
		while {_doLoop} do {
			sleep 0.1;
			if (!(alive _player)) then {
				_doLoop = false;
				[_player, ""] remoteExec ["switchMove", 0, false];
				{
					if ( _x isKindOf "Man") then {
				  		[_x, "Acts_CivilInjuredGeneral_1"] remoteExec ["switchMove", 0];
				  		detach _x;
					};
				} forEach attachedObjects _player;
			};
			if (!(alive _civ)) then {
				_doLoop
			};

		};
	};

	_iDropActionIndex = _player addAction ["drop", {
		_player=_this select 0;
		{
			if ( _x isKindOf "Man") then {
		  		[_x, "Acts_CivilInjuredGeneral_1"] remoteExec ["switchMove", 0];
		  		detach _x;
			};
		} forEach attachedObjects _player;
		_player switchMove "";
		_dropIndex = _player getVariable ["dropActionIndex",-1];
		_player removeAction _dropIndex;
		_loadIndex = _player getVariable ["loadActionIndex",-1];
		_player removeAction _loadIndex;
	},nil,10];
	_player setVariable ["dropActionIndex",_iDropActionIndex];

	_iLoadActionIndex = player addAction ["load wounded in vehicle", {
		_player=_this select 0;
		_nearestVeh = nearestObjects [_player, ["Car","Tank","Truck","Helicopter"], 10];
		if (count _nearestVeh > 0) then {
			{
				if ( _x isKindOf "Man") then {
			  		detach _x;
			  		_x enableAI "anim";
			  		_x setHitPointDamage ["hitLegs", 1];
			  		[_x] join (group _player);
					_x enableAI "MOVE";
					[_x, ""] remoteExec ["switchMove", 0, false];
					sleep 1;
					[_x, (_nearestVeh select 0)] remoteExec ["moveInCargo", 0, false];
			  		[_x, (_nearestVeh select 0)] remoteExec ["assignAsCargo", 0, false];
					[_x, (_nearestVeh select 0)] remoteExec ["moveInCargo", 0, false];
			  		[_x, (_nearestVeh select 0)] remoteExec ["assignAsCargo", 0, false];
				};
			} forEach attachedObjects _player;
			_player switchMove "";
			_dropIndex = _player getVariable ["dropActionIndex",-1];
			_player removeAction _dropIndex;
			_loadIndex = _player getVariable ["loadActionIndex",-1];
			_player removeAction _loadIndex;
		}
		else {
			["No vehicle near"] call TRGM_GLOBAL_fnc_notify;
		};
	},nil,9];
	_player setVariable ["loadActionIndex",_iLoadActionIndex];




}
else {
	["It's too late. this guy is dead"] call TRGM_GLOBAL_fnc_notify;
};

true;
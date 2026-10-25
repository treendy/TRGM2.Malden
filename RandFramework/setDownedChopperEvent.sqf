_iVictimType = selectRandom [1,2,3];  //1=reporter, 2=medic, 3=friendlyPilot
_completedMessage = "";
_PointsAdjustMessage = "";
_sVictim = nil;
_sVictimVeh = nil;
if (_iVictimType == 1) then {
	_sVictim = selectRandom Reporters;
	_sVictimVeh = selectRandom ReporterChoppers;
	_completedMessage = "The stranded reporter has returned to base in one piece!, well done!";
	_PointsAdjustMessage = "Reporter rescued";
};
if (_iVictimType == 2) then {
	_sVictim = selectRandom Paramedics;
	_sVictimVeh = selectRandom AirAmbulances;
	_completedMessage = "The stranded medic has returned to base in one piece!, well done!";
	_PointsAdjustMessage = "Paramedic rescued";
};
if (_iVictimType == 3) then {
	_sVictim = selectRandom FriendlyVictims;
	_sVictimVeh = selectRandom FriendlyVictimVehs;
	_completedMessage = "Our stranded guy has returned to base in one piece!, well done!";
	_PointsAdjustMessage = "Friendly unit rescued";
};


params ["_mainObjPos",["_isFullMap",false]];

//use IDAP with police car???


_flatPos = [_mainObjPos , 200, 2000, 1, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
if (!(isNil "IsTraining") || _isFullMap) then {
	_nearestRoads = _mainObjPos nearRoads 30000;		
	if (count _nearestRoads > 0) then {	
		_thisDownedChopperCenter = getPos (selectRandom _nearestRoads);
		_flatPos = [_thisDownedChopperCenter , 100, 2000, 1, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	};
};


if (str(_flatPos) != "[0,0,0]") then {

	[_flatPos, 5, 4, 5, 3] call TRGM_fnc_spawnEventThreats;

	_wreck = _sVictimVeh createVehicle _flatPos;	
	_wreck setDamage [1,false];	
	if (selectRandom [true,false]) then {
		_objFlame1 = createVehicle ["test_EmptyObjectForFireBig", _flatPos, [], 0, "CAN_COLLIDE"];
	};
	

	//spawn inner sentry
	[_flatPos, selectRandom[0,1,2], 0, 0, 20, false, east, [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse], false, true, true, UnarmedScoutVehicles, 100, true, true, 50] call TRGM_fnc_spawnCheckpoints;

	_flatPos2 = [_flatPos , 10, 25, 3, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	_group = createGroup civilian; 
	_downedCiv = [_group, _sVictim, _flatPos2] call TRGM_fnc_createWoundedCasualty;
	_downedCiv setHitPointDamage ["hitLegs", 1];


	[_downedCiv,["Join Group",{
		_civ=_this select 0; 
		_player=_this select 1;
		[_civ] join (group _player);
		_civ enableAI "MOVE"; 
		_civ removeAction 0; 
		_civ switchMove "Acts_ExecutionVictim_Unbow"; 
		_civ enableAI "anim";
	}]] remoteExec ["addAction", 0, true]; //JIP so joining players get it too 

	[_downedCiv, ["Talk to wounded guy",{hint "Please get me back to base!!"},[_downedCiv]]] remoteExec ["addAction", 0, true];

	[_downedCiv,["Carry",{
		_civ=_this select 0; 
		_player=_this select 1;
		[_civ, _player] execVM "RandFramework\CarryAndJoinWounded.sqf";				
	}]] remoteExec ["addAction", 0, true]; //JIP so joining players get it too 

	[_downedCiv] spawn TRGM_fnc_eventFlareLoop;


	[getPos _downedCiv, "Crash Site"] call TRGM_fnc_createEventMarker;

	_doLoop = true;
	while {_doLoop} do
	{
		if (!alive(_downedCiv)) then {
			_doLoop = false;
		};
		if (_downedCiv distance (getMarkerPos "mrkHQ") < 300) then {
			_doLoop = false;
			[_completedMessage] remoteExecCall ["Hint", 0];
			[0.3, _PointsAdjustMessage] call TRGM_fnc_adjustMaxBadPoints;
			[_downedCiv] join grpNull;
			deleteVehicle _downedCiv;
		};
		sleep 10;
	};

	
};		
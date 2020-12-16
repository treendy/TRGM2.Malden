
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

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

_bloodPools = ["BloodPool_01_Large_New_F","BloodSplatter_01_Large_New_F"];

//use IDAP with police car???



_flatPos = [0,0,0];
_flatPos = [_mainObjPos , 200, 2000, 1, 0, 0.5, 0,[],[[0,0,0],[0,0,0]],_sVictimVeh] call TREND_fnc_findSafePos;
if (!(isNil "IsTraining") || _isFullMap) then {
	_nearestRoads = _mainObjPos nearRoads 30000;
	if (count _nearestRoads > 0) then {
		_thisDownedChopperCenter = getPos (selectRandom _nearestRoads);
		_flatPos = [_thisDownedChopperCenter , 100, 2000, 1, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call TREND_fnc_findSafePos;
	};
};


if (str(_flatPos) != "[0,0,0]") then {

	_groupCamp1 = createGroup east;

	_aaaX = _flatPos select 0;
	_aaaY = _flatPos select 1;


	if (random 1 < .20) then {
		[_flatPos] spawn TREND_fnc_createWaitingAmbush;
		if (random 1 < .25) then {
			[_flatPos] spawn TREND_fnc_createWaitingSuicideBomber;
		};
	};
	if (random 1 < .20) then {
		[_flatPos] spawn TREND_fnc_createWaitingSuicideBomber;
	};
	if (random 1 < .33) then {
		[_flatPos] spawn TREND_fnc_createEnemySniper;
	};

	_wreck = _sVictimVeh createVehicle _flatPos;
	_wreck setDamage [1,false];
	if (random 1 < .50) then {
		_objFlame1 = createVehicle ["test_EmptyObjectForFireBig", _flatPos, [], 0, "CAN_COLLIDE"];
	};


	//spawn inner sentry
	_HasEnemy = false;

	_iCount = selectRandom[0,1,2];
	while {_iCount > 0} do {
		_HasEnemy = true;
		_thisAreaRange = 20;
		_checkPointGuidePos = _flatPos;
		_iCount = _iCount - 1;
		_flatPosSentry = nil;
		_flatPosSentry = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;
		if (_flatPosSentry select 0 > 0) then {
			_thisPosAreaOfCheckpoint = _flatPosSentry;
			_thisRoadOnly = false;
			_thisSide = east;
			_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
			_thisAllowBarakade = false;
			_thisIsDirectionAwayFromAO = true;
			[_flatPos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,(call UnarmedScoutVehicles),100] spawn TREND_fnc_setCheckpoint;
		};
	};

	_flatPos2 = nil;
	_flatPos2 = [_flatPos , 10, 25, 3, 0, 0.5, 0,[],[[0,0,0],[0,0,0]],_sVictim] call TREND_fnc_findSafePos;
	_group = createGroup civilian;
	_downedCiv = _group createUnit [_sVictim,_flatPos2,[],0,"NONE"];


	[_downedCiv,["Join Group",{
		_civ=_this select 0;
		_player=_this select 1;
		[_civ] join (group _player);
		_civ enableAI "MOVE";
		_civ removeAction 0;
		_civ switchMove "Acts_ExecutionVictim_Unbow";
		_civ enableAI "anim";
	}]] remoteExecCall ["addAction", 0];

	//[box1,["hello",
	//	{


	//	}
	//]] remoteExecCall ["addAction", 2];


	//!!!!!CAn i use this to say3d?????
	//	[_downedCiv, ["Join Group", {}]] remoteExec ["addAction", -2, _downedCiv];
	//	[_downedCiv, ["Fortunateson"]] remoteExec ["say3d", -2, _downedCiv];
	//	[_downedCiv, "Fortunateson"] remoteExec ["say3d", -2, _downedCiv];

	_downedCiv setDamage 0.8;
	_downedCiv setHitPointDamage ["hitLegs", 1];
	//if (random 1 < .50 && !_HasEnemy) then {
		[_downedCiv, "Acts_CivilInjuredGeneral_1"] remoteExec ["switchMove", 0];
	//}
	//else {
	//	[_downedCiv, "Acts_ExecutionVictim_Loop"] remoteExec ["switchMove", 0];
	//};


	//_downedCiv playMoveNow "Acts_CivilInjuredGeneral_1"; //"AinjPpneMstpSnonWrflDnon";
	_downedCiv disableAI "anim";
	_downedCivDirection = (floor(random 360));
	_downedCiv setDir (_downedCivDirection);
	_downedCiv addEventHandler ["killed", {_this spawn TREND_fnc_CivKilled;}];
	_bloodPool1 = createVehicle [selectRandom _bloodPools, getpos _downedCiv, [], 0, "CAN_COLLIDE"];
	_bloodPool1 setDir (floor(random 360));
	[_downedCiv, ["Talk to wounded guy",{hint "Please get me back to base!!"},[_downedCiv]]] remoteExec ["addAction", 0, true];
	if (true) then {
		_trialDir = (floor(random 360));
		_trialPos = (getPos _bloodPool1) getPos [3,_trialDir];
		_bloodTrail1 = createVehicle ["BloodTrail_01_New_F", _trialPos, [], 0, "CAN_COLLIDE"];
		_bloodTrail1 setDir _trialDir;
	};

	[_downedCiv,["Carry",{
		_civ=_this select 0;
		_player=_this select 1;
		[_civ, _player] spawn TREND_fnc_CarryAndJoinWounded;
	}]] remoteExecCall ["addAction", 0];

	[_downedCiv] spawn {
		_downedCiv = _this select 0;
		while{ (alive _downedCiv)} do {
			//_downedCiv say3D selectRandom WoundedSounds;
			_woundedSound = selectRandom WoundedSounds;
			[_downedCiv,_woundedSound] remoteExecCall ["say3D", 0];

			//_downedCiv say3D selectRandom WoundedSounds;
			sleep selectRandom [2,2.5,3];
		}

	};

	[_downedCiv] spawn {
		_downedCiv = _this select 0;
		while{ (alive _downedCiv)} do {

			_flareposX = getPos _downedCiv select 0;
			_flareposY = getPos _downedCiv select 1;
			_flare1 = "F_40mm_red" createvehicle [_flareposX+20,_flareposY+20, 250]; _flare1 setVelocity [0,0,-10];

			//_downedCiv say3D selectRandom WoundedSounds;
			sleep selectRandom [600];
		}

	};


	if (!(isNil "IsTraining")) then {
		_markerEventMedi = createMarker [format["_markerEventMedi%1",(floor(random 360))], getPos _downedCiv];
		_markerEventMedi setMarkerShape "ICON";
		_markerEventMedi setMarkerType "hd_dot";
		_markerEventMedi setMarkerText "Crash Site";
	}
	else {
		//if (random 1 < .25) then {
		//if (true) then {
			_markerEventMedi = createMarker [format["_markerEventRescue%1",(floor(random 360))], getPos _downedCiv];
			_markerEventMedi setMarkerShape "ICON";
			_markerEventMedi setMarkerType "hd_dot";
			_markerEventMedi setMarkerText "Distress Signal";
		//};
	};

	_doLoop = true;
	while {_doLoop} do
	{
		if (!alive(_downedCiv)) then {
			_doLoop = false;
		};
		if (_downedCiv distance (getMarkerPos "mrkHQ") < 300) then {
			_doLoop = false;
			[_completedMessage] remoteExecCall ["Hint", 0];
			[0.3, _PointsAdjustMessage] spawn TREND_fnc_AdjustMaxBadPoints;
			[_downedCiv] join grpNull;
			deleteVehicle _downedCiv;
		};
		sleep 10;
	};


};

true;
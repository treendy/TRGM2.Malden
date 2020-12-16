//use IDAP with police car???
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

fnc_AddToDirection = {
	params ["_origDirection","_addToDirection"];

	_iResult = _origDirection + _addToDirection;
	//hint format["result:%1",_iResult];
	//sleep 2;
	if (_iResult > 360) then {
		_iResult = _iResult - 360;
	};
	if (_origDirection+_addToDirection < 0) then {
		_iResult = 360 + _iResult ;
	};

	_iResult;
};

_vehs = CivCars;


params ["_posOfAO",["_isFullMap",false]];
//_posOfAO =  _this select 0;


_nearestRoads = _posOfAO nearRoads 2000;
if (!(isNil "IsTraining") || _isFullMap) then {
	_nearestRoads = _posOfAO nearRoads 30000;
};

if (count _nearestRoads > 0) then {

	_eventLocationPos = getPos (selectRandom _nearestRoads);

	_bIsTrap = random 1 < .40;
	//_bIsTrap = true;


	_thisAreaRange = 50;

	_nearestRoads = _eventLocationPos nearRoads _thisAreaRange;

	_nearestRoad = nil;
	_roadConnectedTo = nil;
	_connectedRoad = nil;
	_direction = nil;
	_PosFound = false;
	_iAttemptLimit = 5;

	_direction = nil;
	while {!_PosFound && _iAttemptLimit > 0 && count _nearestRoads > 0} do {
		_nearestRoad = selectRandom _nearestRoads;
		_roadConnectedTo = roadsConnectedTo _nearestRoad;
		if (count _roadConnectedTo > 0) then {
			_connectedRoad = _roadConnectedTo select 0;
			_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
			_PosFound = true;
		}
		else {
			_iAttemptLimit = _iAttemptLimit - 1;
		};
	};
//hint format["A: %1 - %2",_iteration,_eventLocationPos];
	if (_PosFound) then {


		_roadBlockPos =  getPos _nearestRoad;
		_roadBlockSidePos = _nearestRoad getPos [3, ([_direction,90] call fnc_AddToDirection)];

		_mainVeh = createVehicle [selectRandom _vehs,_roadBlockSidePos,[],0,"NONE"];
		//_mainVeh setVehicleLock "LOCKED";
		_mainVehDirection =  ([_direction,(selectRandom[0,-10,10])] call fnc_AddToDirection);
		_mainVeh setDir _mainVehDirection;
		//_smoke = createvehicle ["test_EmptyObjectForSmoke",getpos _mainVeh,[],0,"CAN_COLLIDE"];
		//_smoke setpos getpos _mainVeh;
		clearItemCargoGlobal _mainVeh;

		_expl1 = nil;
		_expl2 = nil;
		_expl3 = nil;

		if (_bIsTrap) then {

			_expl1 = "DemoCharge_Remote_Ammo" createVehicle position _mainVeh;
   			_expl1 attachTo [_mainVeh, [0, -0.2, -1.65]];
			_expl1 setVectorDirAndUp [[0,0,-1],[0,1,0]];

			_expl2 = "DemoCharge_Remote_Ammo" createVehicle position _mainVeh;
   			_expl2 attachTo [_mainVeh, [0, -0, -1.65]];
			_expl2 setVectorDirAndUp [[0,0,-1],[0,1,0]];

			_expl3 = "DemoCharge_Remote_Ammo" createVehicle position _mainVeh;
   			_expl3 attachTo [_mainVeh, [0, -0.2, -1.65]];
			_expl3 setVectorDirAndUp [[0,0,-1],[0,1,0]];

			if (random 1 < .50) then {
				[_eventLocationPos] spawn TREND_fnc_createWaitingAmbush;
				if (random 1 < .50) then {
					[_eventLocationPos] spawn TREND_fnc_createWaitingSuicideBomber;
				};
			};
			if (random 1 < .33) then {
				[_eventLocationPos] spawn TREND_fnc_createWaitingSuicideBomber;
			};
			if (random 1 < .33) then {
				[_eventLocationPos] spawn TREND_fnc_createEnemySniper;
			};
		};

		if (!(isNil "IsTraining")) then {
			_markerEventMedi = createMarker [format["_markerEventMedi%1",(floor(random 360))], getPos _mainVeh];
			_markerEventMedi setMarkerShape "ICON";
			_markerEventMedi setMarkerType "hd_dot";
			_markerEventMedi setMarkerText "Stranded Civ";
		}
		else {
			if (false) then { //will never show this for broken down civ! (only here if need to test)
				_markerEventMedi = createMarker [format["_markerEventMedi%1",(floor(random 360))], getPos _mainVeh];
				_markerEventMedi setMarkerShape "ICON";
				_markerEventMedi setMarkerType "hd_dot";
				_markerEventMedi setMarkerText "Distress Signal";
			};
		};

		_vehPos = getPos _mainVeh;
		_backOfVehArea = _vehPos getPos [10,([_mainVehDirection,selectRandom[170,180,190]] call fnc_AddToDirection)];
		//_direction is direction of road
		//_mainVehDirection is direction of first veh
		//use these to lay down guys, cones, rubbish, barriers, lights etc...

		//hint str(_backOfVehArea);
		_group = createGroup civilian;
		_downedCiv = _group createUnit [selectRandom sCivilian,_backOfVehArea,[],0,"NONE"];
		[_downedCiv, "Acts_CivilShocked_1"] remoteExec ["switchMove", 0];
		//_downedCiv playMoveNow "Acts_CivilInjuredGeneral_1"; //"AinjPpneMstpSnonWrflDnon";
		_downedCiv disableAI "anim";
		_downedCivDirection = (floor(random 360));
		_downedCiv setDir (_downedCivDirection);
		_downedCiv addEventHandler ["killed", {_this spawn TREND_fnc_CivKilled;}];

		[_downedCiv, ["Ask if needs assistance",{
			_downedCiv = _this select 0;
			if (alive _downedCiv) then {
				hint "Please help, my car has broken down, i need to get home to my family!"
			}
			else {
				hint "Is there a reason you are trying to talk to a dead guy??"
			}
		},[_downedCiv]]] remoteExec ["addAction", 0, true];

		//set veh damage;
		//if (random 1 < .50) then {_mainVeh setHit ["engine",0.75];};
		if (random 1 < .50) then {_mainVeh setHit ["wheel_1_1_steering",1];};
		if (random 1 < .50) then {_mainVeh setHit ["wheel_1_2_steering",1];};
		if (random 1 < .50) then {_mainVeh setHit ["wheel_2_1_steering",1];};
		if (random 1 < .50) then {_mainVeh setHit ["wheel_2_2_steering",1];};
		if (((_mainVeh getHit "wheel_1_1_steering") < 0.5) && ((_mainVeh getHit "wheel_1_2_steering") < 0.5) && ((_mainVeh getHit "wheel_2_1_steering") < 0.5) && ((_mainVeh getHit "wheel_2_2_steering") < 0.5)) then {
			_mainVeh setHit ["wheel_1_1_steering",1];
		};


		_bWaiting = true;
		_bWaveDone = false;
		while {_bWaiting} do {


			if (!(alive _mainVeh)) then {
				_bWaiting = false;
				_runAwayTo = [0,0,0]; //_vehPos getPos [500,([_mainVeh, _downedCiv] call BIS_fnc_DirTo)];
				_downedCiv enableAI "anim";
				_downedCiv switchMove "";
				_downedCiv setBehaviour "CARELESS";
				_downedCiv doMove _runAwayTo;
				_group setSpeedMode "FULL";
				_downedCiv setUnitPos "UP";
			};
			if (!_bWaveDone) then {
				_nearUnits = nearestObjects [(getPos _downedCiv), ["Man","Car","Helicopter"], 100];
				//(driver ((nearestObjects [(getPos box1), ["car"], 20]) select 0)) in switchableUnits
		  		{
		  			if ((driver _x) in switchableUnits || (driver _x) in playableUnits) then {
		  				_bWaveDone = true;

						//[] spawn {};
						[[_downedCiv,_roadBlockPos,_group],{
							_downedCiv = _this select 0;
							_roadBlockPos = _this select 1;
							_group = _this select 2;

							_downedCiv enableAI "anim";
			  				_downedCiv switchMove "";
			  				_downedCiv setBehaviour "CARELESS";
							_group setSpeedMode "FULL";
							_downedCiv setUnitPos "UP";
						}] remoteExec ["spawn", 0];
						_downedCiv doMove _roadBlockPos;
						sleep 3;
						if (alive _downedCiv) then {
							_downedCiv setDir ([_downedCiv, _x] call BIS_fnc_DirTo);
							[_downedCiv, ""] remoteExec ["switchMove", 0];
							sleep 0.1;
							[_downedCiv, "Acts_JetsShooterNavigate_loop"] remoteExec ["switchMove", 0];
							_downedCiv disableAI "anim";
							[_downedCiv] spawn {
								_downedCiv = _this select 0;
								waitUntil {!alive(_downedCiv)};
								[_downedCiv, ""] remoteExec ["switchMove", 0];
							};
							sleep 15;
							_downedCiv enableAI "anim";
							_downedCiv switchMove "";
						};
		  			};
		  		 	if (_bWaveDone) exitWith {true};
		  		} forEach _nearUnits;
		  	};
		  	if (_bWaveDone) then {
			  	//_bIsTrap
			  	if (_bIsTrap) then {
			  		_nearUnits = nearestObjects [(getPos _downedCiv), ["Man"], 10];
			  		{
			  			if ((driver _x) in switchableUnits || (driver _x) in playableUnits || !(alive _downedCiv)) then {
			  				_bWaiting = false;
			  				if (alive _downedCiv) then {
				  				sleep (floor(random 60));
				  				_downedCiv enableAI "anim";
				  				_downedCiv switchMove "";
								_downedCiv setBehaviour "CARELESS";
								_group setSpeedMode "FULL";
								_downedCiv setUnitPos "UP";
								_downedCiv doMove (TREND_ObjectivePossitions select 0);
								sleep 3;
							};
							playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_downedCiv,false,getPosASL _downedCiv,0.5,1.5,0];
							sleep 0.4;
							playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_downedCiv,false,getPosASL _downedCiv,0.5,1.5,0];
							sleep 0.4;
							playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_downedCiv,false,getPosASL _downedCiv,0.5,1.5,0];
							sleep 1.5;
							//do boooooom!!!!
							_expl1 setDamage 1;
							_expl2 setDamage 1;
							_expl3 setDamage 1;
						};
						if (!_bWaiting) exitWith {true};
					} forEach _nearUnits;
			  	}
			  	else {
			  		if (((_mainVeh getHit "wheel_1_1_steering") < 0.5) && ((_mainVeh getHit "wheel_1_2_steering") < 0.5) && ((_mainVeh getHit "wheel_2_1_steering") < 0.5) && ((_mainVeh getHit "wheel_2_2_steering") < 0.5)) then {
			  			_bWaiting = false;
			  			//removeAllActions _downedCiv;
						//_group setSpeedMode "LIMITED";
						//_downedCiv assignAsDriver _mainVeh;
						//[_downedCiv] orderGetIn true;

			  			["Thank you for your help my friend"] remoteExecCall ["Hint", 0];
			  			[_downedCiv] remoteExecCall ["removeAllActions", 0];
						[_group,"LIMITED"] remoteExecCall ["setSpeedMode", 0];
						[_downedCiv,_mainVeh] remoteExecCall ["assignAsDriver", 0];
						[[_downedCiv],true] remoteExecCall ["orderGetIn", 0];
						[0.2, "Helped a stranded civilian"] spawn TREND_fnc_AdjustMaxBadPoints;
						sleep 10;
						[_downedCiv,(TREND_ObjectivePossitions select 0)] remoteExecCall ["doMove", 0];
						//_downedCiv doMove (TREND_ObjectivePossitions select 0);
					};
				};
			};

		  	if (_bWaiting) then {
				sleep 1;
			};
		};


	};


};




//if trap, after waving, civ will wait until player close, then run off and set off bomb (will blow up if civ killed too) (run 2 seconds, beep then 1.5 seconds boom)
//		 (ways to know if bomb,.... see it, civ runs, enemy spotted)

//can use this for IED, 50/50 if trigger man, very low chance of ambush,near zero chance of suicde bomber, addaction on floor in direction of trigger man confirming direction
//	if close to trigger man, get him to detonate car then run away (player gains rep if defused... so only if no trigger man, or trigger man is killed before detonating bomb)
//	car will go boom as soon as player near!!! (if trigger man alive)

true;
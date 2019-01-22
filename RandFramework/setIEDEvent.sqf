
params ["_posOfAO",["_roadRange",2000],["_showMarker",false],["_forceTrap",false],["_objIED",nil],["_IEDType",nil]];

if (isNil "_IEDType") then {
	_IEDType = selectRandom ["CAR","CAR","RUBBLE"];
};
_ieds = nil;
If (_IEDType == "CAR") then {_ieds = CivCars;};
If (_IEDType == "RUBBLE") then {_ieds = IEDFakeClassNames;};


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


_nearestRoads = _posOfAO nearRoads _roadRange;
if (!(isNil "IsTraining") && _roadRange != 2000) then {
	_nearestRoads = _posOfAO nearRoads 30000;		
};

if (count _nearestRoads > 0) then {	

	_eventLocationPos = [0,0,0]; //getPos (selectRandom _nearestRoads);
	_eventPosFound = false;
	_iAttemptLimit = 5;
	if (!isNil "WarzonePos") then {
		while {!_eventPosFound && _iAttemptLimit > 0} do {
			_eventLocationPos = getPos (selectRandom _nearestRoads);
			if (_eventLocationPos distance WarzonePos > 500) then {_eventPosFound = true;};
			_iAttemptLimit = _iAttemptLimit - 1;
		};
	}
	else {
		_eventLocationPos = getPos (selectRandom _nearestRoads);
	};

	if (_eventLocationPos select 0 > 0) then {
	
		_bIsTrap = selectRandom[true,false,false];
		if (_forceTrap) then {
			_bIsTrap = true;
		};
		//_bIsTrap = true;
		_bHasHidingAmbush = false;		
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

			_mainVeh = nil;
			if (isNil "_objIED") then {
				_mainVeh = createVehicle [selectRandom _ieds,_roadBlockSidePos,[],0,"NONE"];
			}
			else {
				_mainVeh = _objIED;
				_mainVeh setPos _roadBlockSidePos;
			};
			_mainVeh setVariable ["isDefused",false];
			//_mainVeh setVehicleLock "LOCKED";
			_mainVehDirection =  ([_direction,(selectRandom[0,-10,10])] call fnc_AddToDirection);
			_mainVeh setDir _mainVehDirection;
			clearItemCargoGlobal _mainVeh;		

			if (_showMarker) then {
				_markerstrcache = createMarker [format ["IEDLoc%1",_eventLocationPos select 0],getPos _mainVeh];
				_markerstrcache setMarkerShape "ICON";
				if (_bIsTrap) then {
					_markerstrcache setMarkerText localize "STR_TRGM2_IEDMarkerText";	
				}
				else {
					_markerstrcache setMarkerText "";	
				};
				_markerstrcache setMarkerType "hd_dot";
			};


			[
				_mainVeh,											// Object the action is attached to
				localize "STR_TRGM2_IEDSearchIED",										// Title of the action
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",	// Idle icon shown on screen
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",	// Progress icon shown on screen
				"_this distance _target < 5",						// Condition for the action to be shown
				"_caller distance _target < 5",						// Condition for the action to progress
				{},													// Code executed when action starts
				{	
					_thisVeh = _this select 0;
					_IEDType = (_this select 3) select 1;
					_alarmActive = _thisVeh getVariable ["alarmActive",false];
					if (floor (random 30) == 0 && _IEDType == "CAR" && !_alarmActive) then {
						[_thisVeh] spawn {
							_thisVeh = _this select 0;
							_thisVeh setVariable ["alarmActive",true, true];
							while {alive _thisVeh && _thisVeh getVariable ["alarmActive",false]} do {
								playSound3D ["a3\sounds_f\weapons\horns\truck_horn_2.wss", _thisVeh];
								sleep 1;
							};
						};
					};
				},			// Code executed on every progress tick
				{
					_thisVeh = _this select 0;
					_thisPlayer = _this select 1;
					_bIsTrap = (_this select 3) select 0;
					if (_thisPlayer getVariable "unitrole" != "Engineer" && selectRandom[true,true,true,false,false]) then {
						hint localize "STR_TRGM2_IEDSearchFailed";						
					}
					else {
						if (_bIsTrap) then {
							hint localize "STR_TRGM2_IEDSearchFound";
							[
								_thisVeh,											// Object the action is attached to
								localize "STR_TRGM2_IEDDefuse",										// Title of the action
								"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",	// Idle icon shown on screen
								"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",	// Progress icon shown on screen
								"_this distance _target < 5",						// Condition for the action to be shown
								"_caller distance _target < 5",						// Condition for the action to progress
								{},													// Code executed when action starts
								{},			// Code executed on every progress tick
								{
									_thisVeh = _this select 0;
									_thisPlayer = _this select 1;
									_bIsTrap = (_this select 3) select 0;
									if (_thisPlayer getVariable "unitrole" != "Engineer" && selectRandom[true,false,false,false]) then {
										hint localize "STR_TRGM2_IEDOhOh";
										sleep 1;
										playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_thisVeh,false,getPosASL _thisVeh,0.5,1.5,0];
										sleep 0.6;
										playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_thisVeh,false,getPosASL _thisVeh,0.5,1.5,0];
										sleep 0.5;
										playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_thisVeh,false,getPosASL _thisVeh,0.5,1.5,0];
										sleep 0.4;
										playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_thisVeh,false,getPosASL _thisVeh,0.5,1.5,0];
										sleep 0.3;
										playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_thisVeh,false,getPosASL _thisVeh,0.5,1.5,0];
										sleep 0.2;
										playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_thisVeh,false,getPosASL _thisVeh,0.5,1.5,0];
										sleep 0.1;
										playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_thisVeh,false,getPosASL _thisVeh,0.5,1.5,0];
										sleep 1;
										//BOOM
										_type = selectRandom ["Bomb_03_F","Missile_AA_04_F","M_Mo_82mm_AT_LG","DemoCharge_Remote_Ammo","DemoCharge_Remote_Ammo","DemoCharge_Remote_Ammo"];
					  					_li_aaa = _type createVehicle (getPos _thisVeh);
										_li_aaa setDamage 1;
										sleep 1;
										_thisVeh setVariable ["isDefused",true, true];
										sleep 4;
										[localize "STR_TRGM2_IEDOneWay"] remoteExecCall ["Hint", 0];
									}
									else {
										_thisVeh setVariable ["isDefused",true, true];
										[0.2, localize "STR_TRGM2_IEDDefused"] execVM "RandFramework\AdjustMaxBadPoints.sqf";	
										removeAllActions _thisVeh;
										[localize "STR_TRGM2_IEDDefused"] remoteExecCall ["Hint", 0];
									}
								},				// Code executed on completion
								{},													// Code executed on interrupted
								[],								// Arguments passed to the scripts as _this select 3
								6,							// Action duration [s]
								100,													// Priority
								false,												// Remove on completion
								false												// Show in unconscious state 
							] remoteExec ["BIS_fnc_holdActionAdd", 0, _thisVeh];	// MP compatible implementation
						}
						else {
							hint localize "STR_TRGM2_IEDNoneFound";
						};		
					}
				},				// Code executed on completion
				{},													// Code executed on interrupted
				[_bIsTrap,_IEDType],								// Arguments passed to the scripts as _this select 3
				6,													// Action duration [s]
				90,													// Priority
				false,												// Remove on completion
				false												// Show in unconscious state 
			] remoteExec ["BIS_fnc_holdActionAdd", 0, _mainVeh];	// MP compatible implementation



			if (_bIsTrap) then {
				
				if (selectRandom [true,false,false,false]) then {
					[_eventLocationPos] execVM "RandFramework\createWaitingAmbush.sqf";
					_bHasHidingAmbush = true;
				};
				if (selectRandom[true,false,false,false,false]) then {
					[_eventLocationPos] execVM "RandFramework\createWaitingSuicideBomber.sqf";
				};

				_allowAPTraps = true;
				_mainVehPos = getPos _mainVeh;
				{
					if (_x distance _mainVehPos < 800) then {
						_allowAPTraps = false;
					};
				} forEach ObjectivePossitions;
				if (selectRandom[true,false,false] && _allowAPTraps) then {
					_minesPlaced = false;
					_iCountMines = 20;
					_mainVehPos = getPos _mainVeh;
					while {_iCountMines > 0} do {

						_xPos = (_mainVehPos select 0)-40;
						_yPos = (_mainVehPos select 1)-40;
						_randomPos = [_xPos+(random 80),_yPos+(random 80),0];
						if (!isOnRoad _randomPos) then {
							//APERSMine ATMine
							_objMine = createMine [selectRandom["APERSMine"], _randomPos, [], 0];
							if ("TEST" == "FALSE") then {
								_markerstrcache = createMarker [format ["IEDMineLoc%1",floor random 999999],_randomPos];
								_markerstrcache setMarkerShape "ICON";
								_markerstrcache setMarkerType "hd_dot";
								_markerstrcache setMarkerText "";	
							};
						};
						_iCountMines = _iCountMines - 1;
					};	
				};
			};


			//set veh damage;
			//if (selectRandom[true,false]) then {_mainVeh setHit ["engine",0.75];};
			_mainVeh setFuel 0;
			if (selectRandom[true,false]) then {_mainVeh setHit ["wheel_1_1_steering",1];};
			if (selectRandom[true,false]) then {_mainVeh setHit ["wheel_1_2_steering",1];};
			if (selectRandom[true,false]) then {_mainVeh setHit ["wheel_2_1_steering",1];};
			if (selectRandom[true,false]) then {_mainVeh setHit ["wheel_2_2_steering",1];};
			_mainVeh setDamage selectRandom[0,0.7];

			_bWaiting = true;
			while {_bWaiting} do {

				
				if (!(alive _mainVeh) || _mainVeh getVariable ["isDefused",false]) then {
					_bWaiting = false; 
				};
				
		  	  	//_bIsTrap
			  	if (_bIsTrap) then {
			  		//LandVehicle
			  		/*if (_bHasHidingAmbush) then {
				  		_nearUnits = nearestObjects [(_roadBlockSidePos), ["Man"], 10];
				  		{
				  			if (alive _expl1 && ((driver _x) in switchableUnits || (driver _x) in playableUnits || !(alive _mainVeh))) then {
				  				_bWaiting = false;
								playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_mainVeh,false,getPosASL _mainVeh,0.5,1.5,0];
								sleep 0.4;
								playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_mainVeh,false,getPosASL _mainVeh,0.5,1.5,0];
								sleep 0.4;
								playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_mainVeh,false,getPosASL _mainVeh,0.5,1.5,0];
								sleep 1.5;
								//do boooooom!!!!
								_expl1 setDamage 1;
							};
							if (!_bWaiting) exitWith {true};
						} forEach _nearUnits;
					};*/
					_nearUnits = nearestObjects [(_roadBlockSidePos), ["LandVehicle"], 10];
			  		{
			  			if ((driver _x) in switchableUnits || (driver _x) in playableUnits || !(alive _mainVeh)) then {
			  				if (selectRandom [true,true]) then {
			  					_type = selectRandom ["Bomb_03_F","Missile_AA_04_F","M_Mo_82mm_AT_LG","DemoCharge_Remote_Ammo","DemoCharge_Remote_Ammo","DemoCharge_Remote_Ammo"];
			  					_li_aaa = _type createVehicle (getPos _mainVeh);
								_li_aaa setDamage 1;
								_mainVeh setVariable ["isDefused",true, true];
								[localize "STR_TRGM2_IEDOmteresting"] remoteExecCall ["Hint", 0];
							};
						};
						if (!_bWaiting) exitWith {true};
					} forEach _nearUnits;
			  	}; 
			  	
			  
			  	if (_bWaiting) then {
					sleep 1;
				};
			};


		};	
	}
	else {
		if (!isNil "_objIED") then {
			deleteVehicle _objIED;
		};
	};
};


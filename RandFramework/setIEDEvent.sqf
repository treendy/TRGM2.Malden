
params ["_posOfAO",["_roadRange",2000],["_showMarker",false],["_forceTrap",false],["_objIED",nil],["_IEDType",nil],["_isFullMap",false]];

if (isNil "_IEDType") then {
	_IEDType = selectRandom ["CAR","CAR","RUBBLE"];
};
_ieds = nil;
If (_IEDType == "CAR") then {_ieds = CivCars;};
If (_IEDType == "RUBBLE") then {_ieds = IEDFakeClassNames;};


_nearestRoads = _posOfAO nearRoads _roadRange;
if ((!(isNil "IsTraining") || _isFullMap) && _roadRange == 2000) then {
	_nearestRoads = _posOfAO nearRoads 30000;		
};
if (count _nearestRoads == 0 && !isNil "_objIED") then {
	_nearestRoads = _posOfAO nearRoads 1000; //a mission IED must be placed somewhere, or its objective can never be completed
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
		if (!_eventPosFound && !isNil "_objIED") then {
			_eventLocationPos = getPos (selectRandom _nearestRoads); //mission IED: near the warzone is better than [0,0,0]
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
		_roadInfo = [_eventLocationPos, 50, 5] call TRGM_fnc_findRoadWithDirection;
		if (count _roadInfo == 0 && !isNil "_objIED") then {
			_roadInfo = [(_eventLocationPos nearRoads 50) select 0, random 360]; //dead end road, still place the mission IED
		};
		if (count _roadInfo > 0) then {
			_roadInfo params ["_nearestRoad","_direction"];

			_roadBlockSidePos = _nearestRoad getPos [3, ([_direction,90] call TRGM_fnc_AddToDirection)];

			_mainVeh = nil;
			if (isNil "_objIED") then {
				_mainVeh = createVehicle [selectRandom _ieds,_roadBlockSidePos,[],0,"NONE"];
			}
			else {
				_mainVeh = _objIED;
				_mainVeh setPos _roadBlockSidePos;
			};
			_mainVeh setVariable ["isDefused",false];
			_mainVehDirection =  ([_direction,(selectRandom[0,-10,10])] call TRGM_fnc_AddToDirection);
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


			[_mainVeh, _bIsTrap, _IEDType] call TRGM_fnc_addIEDSearchAction;


			if (_bIsTrap) then {
				
				[_eventLocationPos, 4, 0, 5, 2] call TRGM_fnc_spawnEventThreats;

				_allowAPTraps = true;
				_mainVehPos = getPos _mainVeh;
				{
					if (_x distance _mainVehPos < 800) then {
						_allowAPTraps = false;
					};
				} forEach ObjectivePossitions;
				if (selectRandom[true,false,false] && _allowAPTraps) then {
					_iCountMines = 20;
					while {_iCountMines > 0} do {

						_xPos = (_mainVehPos select 0)-40;
						_yPos = (_mainVehPos select 1)-40;
						_randomPos = [_xPos+(random 80),_yPos+(random 80),0];
						if (!isOnRoad _randomPos) then {
							//APERSMine ATMine
							_objMine = createMine [selectRandom["APERSMine"], _randomPos, [], 0];
							if (bDebugMode) then { //show mine positions when debugging
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


			_mainVeh setFuel 0;
			[_mainVeh, false] call TRGM_fnc_damageRandomWheels;
			_mainVeh setDamage selectRandom[0,0.7];

			_bWaiting = true;
			while {_bWaiting} do {

				
				if (!(alive _mainVeh) || _mainVeh getVariable ["isDefused",false]) then {
					_bWaiting = false; 
				};
				
		  	  	//_bIsTrap
			  	if (_bIsTrap) then {
			  		//LandVehicle
			  		if (alive _mainVeh) then {
						_nearUnits = nearestObjects [(_roadBlockSidePos), ["LandVehicle"], 10];
						{
							if (((driver _x) in switchableUnits || (driver _x) in playableUnits) && (alive _mainVeh)) then {
								_type = selectRandom ["Bomb_03_F","Missile_AA_04_F","M_Mo_82mm_AT_LG","DemoCharge_Remote_Ammo","DemoCharge_Remote_Ammo","DemoCharge_Remote_Ammo"];
								_li_aaa = _type createVehicle (getPos _mainVeh);
								_li_aaa setDamage 1;
								_mainVeh setVariable ["isDefused",true, true];
								[localize "STR_TRGM2_IEDOmteresting"] remoteExecCall ["Hint", 0];
								_bWaiting = false;
							};
							if (!_bWaiting) exitWith {true};
						} forEach _nearUnits;
			  		}; 
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


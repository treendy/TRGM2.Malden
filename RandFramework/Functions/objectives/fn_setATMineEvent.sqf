params ["_posOfAO",["_isFullMap",false]];

_currentATFieldPos = [_posOfAO , 1000, 1700, 100, 0, 0.4, 0,TREND_AreasBlackList,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;

if (!(isNil "IsTraining") || _isFullMap) then {
	_currentATFieldPos = [_posOfAO , 30000, 1700, 100, 0, 0.4, 0,TREND_AreasBlackList,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
};

if (_currentATFieldPos select 0 != 0) then {

	TREND_ATFieldPos pushBack _currentATFieldPos;

	_minesPlaced = false;
	_iCountMines = 0;
	while {!_minesPlaced} do {

		_xPos = (_currentATFieldPos select 0)-100;
		_yPos = (_currentATFieldPos select 1)-100;
		_randomPos = [_xPos+(random 200),_yPos+(random 200),0];
//APERSMine ATMine
		_objMine = createMine [selectRandom["ATMine"], _randomPos, [], 0];
		if ("TEST" == "FALSE") then {
			_markerstrcache = createMarker [format ["CacheLoc%1",_iCountMines],_randomPos];
			_markerstrcache setMarkerShape "ICON";
			_markerstrcache setMarkerType "hd_dot";
			_markerstrcache setMarkerText "";
		};
		_iCountMines = _iCountMines + 1;
		if (_iCountMines >= 50) then {_minesPlaced = true};
	};

	if (selectRandom [true,false,false,false,false]) then {
		[_currentATFieldPos,200,250] spawn TREND_fnc_createWaitingAmbush;
	};

	if (selectRandom [true,false,false,false,false]) then {
	//if (true) then {
		_mainVeh = createVehicle [selectRandom FriendlyScoutVehicles,_currentATFieldPos,[],0,"NONE"];
		_mainVeh setDir (floor random 360);
		clearItemCargoGlobal _mainVeh;
		if (selectRandom[true,false]) then {_mainVeh setHit ["wheel_1_1_steering",1];};
			if (selectRandom[true,false]) then {_mainVeh setHit ["wheel_1_2_steering",1];};
			if (selectRandom[true,false]) then {_mainVeh setHit ["wheel_2_1_steering",1];};
			if (selectRandom[true,false]) then {_mainVeh setHit ["wheel_2_2_steering",1];};
			if (((_mainVeh getHit "wheel_1_1_steering") < 0.5) && ((_mainVeh getHit "wheel_1_2_steering") < 0.5) && ((_mainVeh getHit "wheel_2_1_steering") < 0.5) && ((_mainVeh getHit "wheel_2_2_steering") < 0.5)) then {
				_mainVeh setHit ["wheel_1_1_steering",1];
		};

		_pos1 = _mainVeh getPos [5,(floor random 360)];
		_pos2 = _mainVeh getPos [5,(floor random 360)];
		_group = createGroup west;
		_sUnitType = selectRandom FriendlyCheckpointUnits;

		_guardUnit1 = _group createUnit [_sUnitType,_pos1,[],0,"NONE"];
		doStop [_guardUnit1];
		_guardUnit1 setDir (floor random 360);
	 	[_guardUnit1,"WATCH","ASIS"] call BIS_fnc_ambientAnimCombat;

	 	_guardUnit2 = _group createUnit [_sUnitType,_pos2,[],0,"NONE"];
		doStop [_guardUnit2];
		_guardUnit2 setDir (floor random 360);
	 	[_guardUnit2,"WATCH","ASIS"] call BIS_fnc_ambientAnimCombat;

		[[_guardUnit1, ["Ask if needs assistance",{
			_guardUnit1 = _this select 0;
			if (alive _guardUnit1) then {
				hint "We are stranded in the middle of an AT mine area.  please help move this car ovrt 100 meters in any direction from here!"
			}
			else {
				hint "Is there a reason you are trying to talk to a dead guy??"
			}
		},[_guardUnit1]]],"addAction",true,true] call BIS_fnc_MP;

	 	[_mainVeh,_guardUnit1,_group] spawn {
	 		_mainVeh = _this select 0;
	 		_guardUnit1 = _this select 1;
	 		_group = _this select 2;
		 	_bWaiting = true;
			_bWaveDone = false;
			while {_bWaiting} do {
				if (!(alive _mainVeh)) then {
					_bWaiting = false;
				}
				else {
					if (!_bWaveDone) then {
						_nearUnits = nearestObjects [(getPos _guardUnit1), ["Man","Car","Helicopter"], 100];
						//(driver ((nearestObjects [(getPos box1), ["car"], 20]) select 0)) in switchableUnits
				  		{
				  			if ((driver _x) in switchableUnits || (driver _x) in playableUnits) then {
				  				_bWaveDone = true;

								//[] spawn {};
								[[_guardUnit1,_group],{
									_guardUnit1 = _this select 0;
									_group = _this select 1;
									_guardUnit1 enableAI "anim";
					  				_guardUnit1 switchMove "";
					  				_guardUnit1 setBehaviour "CARELESS";
									_group setSpeedMode "FULL";
									_guardUnit1 setUnitPos "UP";
								}] remoteExec ["spawn", 0];
								sleep 0.5;
								if (alive _guardUnit1) then {
									_dirToPlayer = ([_guardUnit1, _x] call BIS_fnc_DirTo);
									_moveToPos = _guardUnit1 getPos [6,_dirToPlayer];
									_guardUnit1 doMove _moveToPos;
									sleep 3;
									_guardUnit1 setDir _dirToPlayer;
									[_guardUnit1, ""] remoteExec ["switchMove", 0];
									sleep 0.1;
									[_guardUnit1, "Acts_JetsShooterNavigate_loop"] remoteExec ["switchMove", 0];
									_guardUnit1 disableAI "anim";
									[_guardUnit1] spawn {
										_guardUnit1 = _this select 0;
										waitUntil {!alive(_guardUnit1)};
										[_guardUnit1, ""] remoteExec ["switchMove", 0];
									};
									sleep 20;
									_guardUnit1 enableAI "anim";
									_guardUnit1 switchMove "";
								};
				  			};
				  		 	if (_bWaveDone) exitWith {true};
				  		} forEach _nearUnits;
				  	};
				  	if (_bWaveDone) then {
				  		if ((_mainVeh distance _guardUnit1) > 100) then {
				  			["Thank you for your help"] remoteExecCall ["Hint", 0];
				  			[_guardUnit1] remoteExecCall ["removeAllActions", 0];
				  			[0.2, "Helped a stranded friendly"] spawn TREND_fnc_AdjustMaxBadPoints;
				  			_bWaiting = false;
				  		};
				  	};
				};
				if (_bWaiting) then {
					sleep 1;
				};
			};
		};
	};
};

true;
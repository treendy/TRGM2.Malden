
params ["_posOfAO",["_isFullMap",false]];

_currentATFieldPos = [_posOfAO , 1000, 1700, 100, 0, 0.4, 0,AreasBlackList,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;

if (!(isNil "IsTraining") || _isFullMap) then {
	_currentATFieldPos = [_posOfAO , 1000, 30000, 100, 0, 0.4, 0,AreasBlackList,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
};

if (_currentATFieldPos select 0 != 0) then {

	ATFieldPos pushBack _currentATFieldPos;

	_iCountMines = 0;
	while {_iCountMines < 50} do {

		_xPos = (_currentATFieldPos select 0)-100;
		_yPos = (_currentATFieldPos select 1)-100;
		_randomPos = [_xPos+(random 200),_yPos+(random 200),0];
//APERSMine ATMine
		_objMine = createMine [selectRandom["ATMine"], _randomPos, [], 0];
		if (bDebugMode) then { //show mine positions when debugging
			_markerstrcache = createMarker [format ["CacheLoc%1",_iCountMines],_randomPos];
			_markerstrcache setMarkerShape "ICON";
			_markerstrcache setMarkerType "hd_dot";
			_markerstrcache setMarkerText "";	
		};
		_iCountMines = _iCountMines + 1;
	};

	if (selectRandom [true,false,false,false,false]) then {
		[_currentATFieldPos,200,250] spawn TRGM_fnc_createWaitingAmbush;
	};			
				
	if (selectRandom [true,false,false,false,false]) then {			
		_mainVeh = createVehicle [selectRandom FriendlyScoutVehicles,_currentATFieldPos,[],0,"NONE"];
		_mainVeh setDir (floor random 360);
		clearItemCargoGlobal _mainVeh;		
		[_mainVeh] call TRGM_fnc_damageRandomWheels;

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

		[_guardUnit1, ["Ask if needs assistance",{
			_guardUnit1 = _this select 0;
			if (alive _guardUnit1) then {
				hint "We are stranded in the middle of an AT mine area.  please help move this car ovrt 100 meters in any direction from here!"
			}
			else {
				hint "Is there a reason you are trying to talk to a dead guy??"
			}
		},[_guardUnit1]]] remoteExec ["addAction", 0, true];

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
						_bWaveDone = [_guardUnit1, _group, 100, 20] call TRGM_fnc_waveDownPlayer;
					};
				  	if (_bWaveDone) then {
				  		if ((_mainVeh distance _guardUnit1) > 100) then {
				  			["Thank you for your help"] remoteExecCall ["Hint", 0];
				  			[_guardUnit1] remoteExecCall ["removeAllActions", 0];	
				  			[0.2, "Helped a stranded friendly"] call TRGM_fnc_adjustMaxBadPoints;	
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
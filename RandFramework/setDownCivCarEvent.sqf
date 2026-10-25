
//use IDAP with police car???

_vehs = CivCars;


params ["_posOfAO",["_isFullMap",false]];


_nearestRoads = _posOfAO nearRoads 2000;
if (!(isNil "IsTraining") || _isFullMap) then {
	_nearestRoads = _posOfAO nearRoads 30000;		
};

if (count _nearestRoads > 0) then {	

	_eventLocationPos = getPos (selectRandom _nearestRoads);

	_bIsTrap = selectRandom[true,true,false,false,false];
	

	_roadInfo = [_eventLocationPos, 50, 5] call TRGM_fnc_findRoadWithDirection;
	if (count _roadInfo > 0) then {
		_roadInfo params ["_nearestRoad","_direction"];

		
		_roadBlockPos =  getPos _nearestRoad;
		_roadBlockSidePos = _nearestRoad getPos [3, ([_direction,90] call TRGM_fnc_AddToDirection)];

		_mainVeh = createVehicle [selectRandom _vehs,_roadBlockSidePos,[],0,"NONE"];
		_mainVehDirection =  ([_direction,(selectRandom[0,-10,10])] call TRGM_fnc_AddToDirection);
		_mainVeh setDir _mainVehDirection;
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
   			_expl3 attachTo [_mainVeh, [0, 0.2, -1.65]];
			_expl3 setVectorDirAndUp [[0,0,-1],[0,1,0]];

			[_eventLocationPos, 2, 2, 3, 3] call TRGM_fnc_spawnEventThreats;
		};

		[getPos _mainVeh, "Stranded Civ", 0] call TRGM_fnc_createEventMarker; //0 = never show a distress marker for a broken down civ (set to e.g. 4 if need to test)
	
		_vehPos = getPos _mainVeh;
		_backOfVehArea = _vehPos getPos [10,([_mainVehDirection,selectRandom[170,180,190]] call TRGM_fnc_AddToDirection)];
		//_direction is direction of road
		//_mainVehDirection is direction of first veh
		//use these to lay down guys, cones, rubbish, barriers, lights etc...

		_group = createGroup civilian; 
		_downedCiv = _group createUnit [selectRandom sCivilian,_backOfVehArea,[],0,"NONE"];
		[_downedCiv, "Acts_CivilShocked_1"] remoteExec ["switchMove", 0];
		_downedCiv disableAI "anim";  
		_downedCiv setDir (floor(random 360));
		_downedCiv addEventHandler ["killed", {_this spawn TRGM_fnc_CivKilled;}];		
		
		[_downedCiv, ["Ask if needs assistance",{
			_downedCiv = _this select 0;
			if (alive _downedCiv) then {
				hint "Please help, my car has broken down, i need to get home to my family!"
			}
			else {
				hint "Is there a reason you are trying to talk to a dead guy??"
			}
		},[_downedCiv]]] remoteExec ["addAction", 0, true];

		[_mainVeh] call TRGM_fnc_damageRandomWheels;


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
				_bWaveDone = [_downedCiv, _group, 100, 15, _roadBlockPos] call TRGM_fnc_waveDownPlayer;
			};
			if (_bWaveDone) then {
				if (_bIsTrap) then {
					//detonate when a player on foot gets close (still detonate if he was killed)
					if (!(alive _downedCiv) || {((switchableUnits + playableUnits) findIf {isNull objectParent _x && {_x distance _downedCiv < 10}}) > -1}) then {
						_bWaiting = false;
						if (alive _downedCiv) then {
							sleep (floor(random 60));
							_downedCiv enableAI "anim";  
							_downedCiv switchMove "";
							_downedCiv setBehaviour "CARELESS";
							_group setSpeedMode "FULL";
							_downedCiv setUnitPos "UP";
							_downedCiv doMove (ObjectivePossitions select 0);
							sleep 3;
						};
						{
							playSound3D ["A3\Sounds_F\sfx\beep_target.wss",_downedCiv,false,getPosASL _downedCiv,0.5,1.5,0];
							sleep _x;
						} forEach [0.4,0.4,1.5];
						//do boooooom!!!!
						_expl1 setDamage 1;
						_expl2 setDamage 1;
						_expl3 setDamage 1;
					};
			  	} 
			  	else {
			  		if (((_mainVeh getHit "wheel_1_1_steering") < 0.5) && ((_mainVeh getHit "wheel_1_2_steering") < 0.5) && ((_mainVeh getHit "wheel_2_1_steering") < 0.5) && ((_mainVeh getHit "wheel_2_2_steering") < 0.5)) then {
			  			_bWaiting = false;

			  			["Thank you for your help my friend"] remoteExecCall ["Hint", 0];
			  			[_downedCiv] remoteExecCall ["removeAllActions", 0];					
						[_group,"LIMITED"] remoteExecCall ["setSpeedMode", 0];
						[_downedCiv,_mainVeh] remoteExecCall ["assignAsDriver", 0];					
						[[_downedCiv],true] remoteExecCall ["orderGetIn", 0];			
						[0.2, "Helped a stranded civilian"] call TRGM_fnc_adjustMaxBadPoints;
						sleep 10;
						[_downedCiv,(ObjectivePossitions select 0)] remoteExecCall ["doMove", 0];
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

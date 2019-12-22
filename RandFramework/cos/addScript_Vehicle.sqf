/*
Add Script to vehicles spawned by COS.
_veh = Vehicle. Refer to vehicle as _veh.
*/

_veh =(_this select 0);

_bIsTrap = selectRandom[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
_IEDType = "CAR";

[[_veh, ["Tell driver to get out",{
			_veh = _this select 0;
			_unit = driver _veh;
			if (alive _unit) then {
				_unit action ["getout", _veh];
				_unit disableAI "MOVE";
				_tempGroup1 = createGroup WEST;
				{[_x] joinSilent _tempGroup1} forEach (units group _unit);
				while {(count (waypoints group _unit)) > 0} do {
					deleteWaypoint ((waypoints group _unit) select 0);
				};
			}
			else {
				hint "are actually trying to talk to a ghost?"
			}
		},[_veh]]],"addAction",true,true] call BIS_fnc_MP;



[
				_veh,											// Object the action is attached to
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
							_beepLimit = 20;
							_endLoop = false;
							while {!_endLoop && alive _thisVeh && _thisVeh getVariable ["alarmActive",false]} do {
								playSound3D ["a3\sounds_f\weapons\horns\truck_horn_2.wss", _thisVeh];
								sleep 1;
								_beepLimit = _beepLimit - 1;
								if (_beepLimit < 1) then {_endLoop = true;};
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
			] remoteExec ["BIS_fnc_holdActionAdd", 0, _veh];	// MP compatible implementation
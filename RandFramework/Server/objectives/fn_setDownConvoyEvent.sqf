
_bloodPools = ["BloodPool_01_Large_New_F","BloodSplatter_01_Large_New_F"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

//use IDAP with police car???

fnc_AddToDirection = {
	params ["_origDirection","_addToDirection"];

	_iResult = _origDirection + _addToDirection;
	//[format["result:%1",_iResult]] call TRGM_GLOBAL_fnc_notify;
	//sleep 2;
	if (_iResult > 360) then {
		_iResult = _iResult - 360;
	};
	if (_origDirection+_addToDirection < 0) then {
		_iResult = 360 + _iResult ;
	};

	_iResult;
};

_vehs = (call FriendlyUnarmedCar) + (call FriendlyMedicalTruck) + (call FriendlyArmoredCar) + (call FriendlyFuelTruck) + (call FriendlyFuelTruck) + (call FriendlyFuelTruck);


_posOfAO =  _this select 0;

_nearestRoads = _posOfAO nearRoads 3000;
if (!(isNil "IsTraining")) then {
	_nearestRoads = _posOfAO nearRoads 30000;
};

if (count _nearestRoads > 0) then {

	_eventLocationPos = getPos (selectRandom _nearestRoads);

	if (random 1 < .33) then {
		[_eventLocationPos] spawn TRGM_SERVER_fnc_createWaitingAmbush;
		if (random 1 < .50) then {
			[_eventLocationPos] spawn TRGM_SERVER_fnc_createWaitingSuicideBomber;
		};
	};
	if (random 1 < .33) then {
		[_eventLocationPos] spawn TRGM_SERVER_fnc_createWaitingSuicideBomber;
	};

	_thisAreaRange = 50;
	_iteration = 1;

	while {_iteration <= 3} do {
		//[str(_iteration)] call TRGM_GLOBAL_fnc_notify;
		if (_iteration isEqualTo 2) then {
			_thisAreaRange = 50;
		};
		//[str(_thisAreaRange)] call TRGM_GLOBAL_fnc_notify;

		_nearestRoads = _eventLocationPos nearRoads _thisAreaRange;

		_nearestRoad = nil;
		_roadConnectedTo = nil;


		_connectedRoad = nil;
		_direction = nil;
		//["2"] call TRGM_GLOBAL_fnc_notify;
		//sleep 1;

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
	//[format["A: %1 - %2",_iteration,_eventLocationPos]] call TRGM_GLOBAL_fnc_notify;
		if (_PosFound) then {

			_roadBlockPos =  getPos _nearestRoad;
			_roadBlockSidePos = _nearestRoad getPos [10, ([_direction,90] call fnc_AddToDirection)];

			_mainVeh = createVehicle [selectRandom _vehs,_roadBlockPos,[],0,"NONE"];
			_mainVeh setHit ["karoserie",0.75];
			//_mainVeh setVehicleLock "LOCKED";
			_mainVehDirection =  ([_direction,(selectRandom[0,-10,10])] call fnc_AddToDirection);
			_mainVeh setDir _mainVehDirection;
			clearItemCargoGlobal _mainVeh;
			[
				_mainVeh,
				["CivAmbulance",1],
				["Door_1_source",1,"Door_2_source",0,"Door_3_source",0,"Door_4_source",1,"Hide_Door_1_source",0,"Hide_Door_2_source",0,"Hide_Door_3_source",0,"Hide_Door_4_source",0,"lights_em_hide",1,"ladder_hide",1,"spare_tyre_holder_hide",1,"spare_tyre_hide",1,"reflective_tape_hide",0,"roof_rack_hide",0,"LED_lights_hide",0,"sidesteps_hide",0,"rearsteps_hide",0,"side_protective_frame_hide",1,"front_protective_frame_hide",1,"beacon_front_hide",0,"beacon_rear_hide",0]
			] call BIS_fnc_initVehicle;

			if (_iteration isEqualTo 1) then {
				[_mainVeh] spawn {
					_mainVeh = _this select 0;
					while{ (alive _mainVeh)} do {
						playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom TRGM_VAR_FriendlyRadioSounds + ".wss",_mainVeh,false,getPosASL _mainVeh,0.5,1,0];
						sleep selectRandom [10,15,20,30];
					};
				};

				if (!(isNil "IsTraining")) then {
					_markerEventMedi = createMarker [format["_markerEventMedi%1",(floor(random 360))], getPos _mainVeh];
					_markerEventMedi setMarkerShape "ICON";
					_markerEventMedi setMarkerType "hd_dot";
					_markerEventMedi setMarkerText "Ambushed Friendly Convoy";
				}
				else {
					//if (random 1 < .25) then {
					//if (true) then {
						_markerEventMedi = createMarker [format["_markerEventMedi%1",(floor(random 360))], getPos _mainVeh];
						_markerEventMedi setMarkerShape "ICON";
						_markerEventMedi setMarkerType "hd_dot";
						_markerEventMedi setMarkerText "Distress Signal";
					//};
				};

			};

	if (random 1 < .50) then {
		[_mainVeh] spawn {
			_mainVeh = _this select 0;
			while{ (alive _mainVeh)} do {

				_flareposX = getPos _mainVeh select 0;
				_flareposY = getPos _mainVeh select 1;
				_flare1 = "F_40mm_red" createvehicle [_flareposX+20,_flareposY+20, 250]; _flare1 setVelocity [0,0,-10];

				sleep selectRandom [600];
			}

		};
	};



	if (isnil "fncMedicalParamedicLight") then {
		fncMedicalParamedicLight = {
			params ["_downedCivMedic"];
			_medicLight = "#lightpoint" createVehicle getpos _downedCivMedic;
			_medicLight setLightColor [255, 255, 255]; //red
			_medicLight setLightBrightness 0.03;
			_medicLight setLightAmbient [0.5,0.5,0.8];
			_medicLight lightAttachObject [_downedCivMedic, [0, 1, 1]];

		};
		publicVariable "fncMedicalParamedicLight";
	};

			[_mainVeh] remoteExec ["fncMedicalFlashLights", 0, true];


			_vehPos = getPos _mainVeh;
			_backOfVehArea = _vehPos getPos [5,([_mainVehDirection,floor(random 360)] call fnc_AddToDirection)];
			//_direction is direction of road
			//_mainVehDirection is direction of first veh
			//use these to lay down guys, cones, rubbish, barriers, lights etc...

			//[str(_backOfVehArea)] call TRGM_GLOBAL_fnc_notify;
			_group = createGroup civilian;
			_downedCiv = _group createUnit [selectRandom (call FriendlyCheckpointUnits),_backOfVehArea,[],0,"NONE"];
			_downedCiv setDamage 0.8;
			[_downedCiv, "Acts_CivilInjuredGeneral_1"] remoteExec ["switchMove", 0];
			//_downedCiv playMoveNow "Acts_CivilInjuredGeneral_1"; //"AinjPpneMstpSnonWrflDnon";
			_downedCiv disableAI "anim";
			_downedCivDirection = (floor(random 360));
			_downedCiv setDir (_downedCivDirection);
			_downedCiv addEventHandler ["killed", {_this spawn TRGM_SERVER_fnc_civKilled;}];
			_bloodPool1 = createVehicle [selectRandom _bloodPools, getpos _downedCiv, [], 0, "CAN_COLLIDE"];
			_bloodPool1 setDir (floor(random 360));
			if (true) then {
				_trialDir = (floor(random 360));
				_trialPos = (getPos _bloodPool1) getPos [3,_trialDir];
				_bloodTrail1 = createVehicle ["BloodTrail_01_New_F", _trialPos, [], 0, "CAN_COLLIDE"];
				_bloodTrail1 setDir _trialDir;
			};

			[_downedCiv] spawn {
				_downedCiv = _this select 0;
				while{ (alive _downedCiv)} do {
					_downedCiv say3D selectRandom WoundedSounds;
					sleep selectRandom [2,2.5,3];
				}

			};



			//Paramedics object1 attachTo [object2, offset, memPoint]
			//_group = createGroup civilian;
			_downedCivMedic = _group createUnit [selectRandom (call FriendlyCheckpointUnits),_backOfVehArea,[],0,"CAN_COLLIDE"];
			_downedCivMedic playmove "Acts_TreatingWounded02";
			_downedCivMedic disableAI "anim";
			_downedCivMedic attachTo [_downedCiv, [0.5,-0.3,-0.1]];
			_downedCivMedic setDir 270;
			_downedCivMedic addEventHandler ["killed", {_this spawn TRGM_SERVER_fnc_paramedicKilled;}]; //ParamedicKilled

			[_downedCiv,["Carry",{
				_civ=_this select 0;
				_player=_this select 1;
				[_civ, _player] spawn TRGM_GLOBAL_fnc_carryAndJoinWounded;
			}]] remoteExecCall ["addAction", 0];
			[_downedCiv] spawn {
				_downedCiv = _this select 0;
				_doLoop = true;
				while {_doLoop} do
				{
					if (!alive(_downedCiv)) then {
						_doLoop = false;
					};
					if (_downedCiv distance (getMarkerPos "mrkHQ") < 500) then {
						_doLoop = false;
						["Wounded unit returned to base"] call TRGM_GLOBAL_fnc_notifyGlobal;
						[0.1, format["Brought wounded %1 to base",name _downedCiv]] spawn TRGM_GLOBAL_fnc_adjustMaxBadPoints;
						[_downedCiv] join grpNull;
						deleteVehicle _downedCiv;
					};
					sleep 10;

				};
			};

			[_downedCivMedic] remoteExec ["fncMedicalParamedicLight", 0, true];

			_Crater = createVehicle ["Crater", _backOfVehArea, [], 20, "CAN_COLLIDE"];

			if (_iteration isEqualTo 1) then {

				_downedCivMedic2 = _group createUnit [selectRandom (call FriendlyCheckpointUnits),_backOfVehArea,[],8,"NONE"];
				_downedCivMedic2 playmove "Acts_CivilListening_2";
				_downedCivMedic2 disableAI "anim";
				_downedCivMedic2 addEventHandler ["killed", {_this spawn TRGM_SERVER_fnc_paramedicKilled;}]; //ParamedicKilled

				//_RequestedMedicalItems

				_downedCiv2 = _group createUnit [selectRandom (call FriendlyCheckpointUnits),getpos _downedCivMedic2,[],2,"NONE"];
				_downedCiv2 playmove "Acts_CivilTalking_2";
				_downedCiv2 disableAI "anim";
				_downedCiv2 addEventHandler ["killed", {_this spawn TRGM_SERVER_fnc_civKilled;}]; //ParamedicKilled
				[_downedCiv2, ["Ask if needs assistance",{["We need to get our wounded out of here, help us get these guys back to base!!"] call TRGM_GLOBAL_fnc_notify;},[_downedCiv2]]] remoteExec ["addAction", 0, true];
				_directionFromMed2ToCiv2 = [_downedCivMedic2, _downedCiv2] call BIS_fnc_DirTo;
				_downedCivMedic2 setDir _directionFromMed2ToCiv2;
				_directionFromCiv2ToMed2 = [_downedCiv2, _downedCivMedic2] call BIS_fnc_DirTo;
				_downedCiv2 setDir _directionFromCiv2ToMed2;

				/*[_downedCiv2] spawn {
					_downedCiv2 = _this select 0;
					waitUntil {sleep 2; behaviour _downedCiv2 isEqualTo "combat"};
					_downedCiv2 call BIS_fnc_ambientAnim__terminate;
				};*/


			};
			if (_iteration isEqualTo 2) then {


				_downedCiv3 = _group createUnit [selectRandom (call FriendlyCheckpointUnits),_backOfVehArea,[],25,"NONE"];
				_downedCiv3 playmove "Acts_CivilShocked_1";
				_downedCiv3 disableAI "anim";
				_downedCiv3 setDir (floor(random 360));
				_downedCiv3 addEventHandler ["killed", {_this spawn TRGM_SERVER_fnc_civKilled;}]; //ParamedicKilled
			};

			_rubbish1 = createVehicle [selectRandom TRGM_VAR_MedicalMessItems, getpos _downedCiv, [], 1.5, "CAN_COLLIDE"];
			_rubbish1 setDir (floor(random 360));

			_rubbish2 = createVehicle [selectRandom TRGM_VAR_MedicalMessItems, getpos _downedCiv, [], 1.5, "CAN_COLLIDE"];
			_rubbish2 setDir (floor(random 360));


			//_upRoadPos = _vehPos getpos [10,_direction];
			_nearestRoadsPoint2 = _vehPos nearRoads 25;
			_maxRoads2 = count _nearestRoadsPoint2;
			_selIndex = selectRandom [0,(_maxRoads2-1)];
			_nearestRoad2 = _nearestRoadsPoint2 select 0;
			_roadConnectedTo2 = roadsConnectedTo _nearestRoad2;


			_flatPos = nil;
			_flatPos = [_vehPos , 10, 15, 10, 0, 0.3, 0,[],[[0,0,0],[0,0,0]],selectRandom _vehs] call TRGM_GLOBAL_fnc_findSafePos;



			_buildings = nearestObjects [_vehPos, TRGM_VAR_BasicBuildings, 100];
			//[str(count _buildings)] call TRGM_GLOBAL_fnc_notify;
			if (count _buildings < 5 && _iteration isEqualTo 1) then {
				_car1 = createVehicle [selectRandom _vehs, _flatPos, [], 0, "CAN_COLLIDE"];
				_car1 setDamage [1,false];
				_car1 setDir (floor(random 360));
				_objFlame1 = createVehicle ["test_EmptyObjectForFireBig", _flatPos, [], 0, "CAN_COLLIDE"];

			};


			//CivCars


		};



		_iteration = _iteration + 1;
	};




};




true;
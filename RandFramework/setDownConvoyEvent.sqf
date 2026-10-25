
//use IDAP with police car???

_vehs = FriendlyUnarmedCar + FriendlyMedicalTruck + FriendlyArmoredCar + FriendlyFuelTruck + FriendlyFuelTruck + FriendlyFuelTruck;


_posOfAO =  _this select 0;

_nearestRoads = _posOfAO nearRoads 3000;
if (!(isNil "IsTraining")) then {
	_nearestRoads = _posOfAO nearRoads 30000;		
};

if (count _nearestRoads > 0) then {	

	_eventLocationPos = getPos (selectRandom _nearestRoads);

	[_eventLocationPos, 3, 2, 3, 0] call TRGM_fnc_spawnEventThreats;

	_iteration = 1;

	while {_iteration <= 3} do {

		_roadInfo = [_eventLocationPos, 50, 5] call TRGM_fnc_findRoadWithDirection;
		if (count _roadInfo > 0) then {
			_roadInfo params ["_nearestRoad","_direction"];

			_roadBlockPos =  getPos _nearestRoad;

			_mainVeh = createVehicle [selectRandom _vehs,_roadBlockPos,[],0,"NONE"];
			_mainVeh setHit ["karoserie",0.75];
			_mainVehDirection =  ([_direction,(selectRandom[0,-10,10])] call TRGM_fnc_AddToDirection);
			_mainVeh setDir _mainVehDirection;
			clearItemCargoGlobal _mainVeh;
			[
				_mainVeh,
				["CivAmbulance",1], 
				["Door_1_source",1,"Door_2_source",0,"Door_3_source",0,"Door_4_source",1,"Hide_Door_1_source",0,"Hide_Door_2_source",0,"Hide_Door_3_source",0,"Hide_Door_4_source",0,"lights_em_hide",1,"ladder_hide",1,"spare_tyre_holder_hide",1,"spare_tyre_hide",1,"reflective_tape_hide",0,"roof_rack_hide",0,"LED_lights_hide",0,"sidesteps_hide",0,"rearsteps_hide",0,"side_protective_frame_hide",1,"front_protective_frame_hide",1,"beacon_front_hide",0,"beacon_rear_hide",0]
			] call BIS_fnc_initVehicle;

			if (_iteration == 1) then {
				[_mainVeh] spawn {
					_mainVeh = _this select 0;
					while{ (alive _mainVeh)} do {
						playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom FriendlyRadioSounds + ".wss",_mainVeh,false,getPosASL _mainVeh,0.5,1,0];
						sleep selectRandom [10,15,20,30];
					};
				};

				[getPos _mainVeh, "Ambushed Friendly Convoy"] call TRGM_fnc_createEventMarker;
			};

			if (selectRandom [true,false]) then {
				[_mainVeh] spawn TRGM_fnc_eventFlareLoop;
			};

			[_mainVeh] remoteExec ["TRGM_fnc_medicalFlashLights", 0, true];


			_vehPos = getPos _mainVeh;
			_backOfVehArea = _vehPos getPos [5,([_mainVehDirection,floor(random 360)] call TRGM_fnc_AddToDirection)];
			//_direction is direction of road
			//_mainVehDirection is direction of first veh
			//use these to lay down guys, cones, rubbish, barriers, lights etc...

			_group = createGroup civilian; 
			_downedCiv = [_group, selectRandom FriendlyCheckpointUnits, _backOfVehArea] call TRGM_fnc_createWoundedCasualty;
			_downedCivMedic = [_group, selectRandom FriendlyCheckpointUnits, _backOfVehArea, _downedCiv] call TRGM_fnc_createTreatingMedic;

			[_downedCiv,["Carry",{
				_civ=_this select 0; 
				_player=_this select 1;
				[_civ, _player] execVM "RandFramework\CarryAndJoinWounded.sqf";				
			}]] remoteExec ["addAction", 0, true]; //JIP so joining players get it too 
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
						["Wounded unit returned to base"] remoteExecCall ["Hint", 0];
						[0.1, format["Brought wounded %1 to base",name _downedCiv]] call TRGM_fnc_adjustMaxBadPoints;
						[_downedCiv] join grpNull;
						deleteVehicle _downedCiv;
					};
					sleep 10;

				};
			};

			_Crater = createVehicle ["Crater", _backOfVehArea, [], 20, "CAN_COLLIDE"];
			
			if (_iteration == 1) then {
								
				_downedCivMedic2 = _group createUnit [selectRandom FriendlyCheckpointUnits,_backOfVehArea,[],8,"NONE"];
				_downedCivMedic2 playmove "Acts_CivilListening_2";
				_downedCivMedic2 disableAI "anim";  
				_downedCivMedic2 addEventHandler ["killed", {_this spawn TRGM_fnc_ParamedicKilled;}]; //ParamedicKilled

				_downedCiv2 = _group createUnit [selectRandom FriendlyCheckpointUnits,getpos _downedCivMedic2,[],2,"NONE"];
				_downedCiv2 playmove "Acts_CivilTalking_2";
				_downedCiv2 disableAI "anim";  
				_downedCiv2 addEventHandler ["killed", {_this spawn TRGM_fnc_CivKilled;}]; //ParamedicKilled
				[_downedCiv2, ["Ask if needs assistance",{hint "We need to get our wounded out of here, help us get these guys back to base!!"},[_downedCiv2]]] remoteExec ["addAction", 0, true];
				_directionFromMed2ToCiv2 = [_downedCivMedic2, _downedCiv2] call BIS_fnc_DirTo; 
				_downedCivMedic2 setDir _directionFromMed2ToCiv2;	
				_directionFromCiv2ToMed2 = [_downedCiv2, _downedCivMedic2] call BIS_fnc_DirTo; 
				_downedCiv2 setDir _directionFromCiv2ToMed2;	
			};
			if (_iteration == 2) then {
				_downedCiv3 = _group createUnit [selectRandom FriendlyCheckpointUnits,_backOfVehArea,[],25,"NONE"];
				_downedCiv3 playmove "Acts_CivilShocked_1";
				_downedCiv3 disableAI "anim";  
				_downedCiv3 setDir (floor(random 360));
				_downedCiv3 addEventHandler ["killed", {_this spawn TRGM_fnc_CivKilled;}]; //ParamedicKilled
			};

			_rubbish1 = createVehicle [selectRandom MedicalMessItems, getpos _downedCiv, [], 1.5, "CAN_COLLIDE"];
			_rubbish1 setDir (floor(random 360));

			_rubbish2 = createVehicle [selectRandom MedicalMessItems, getpos _downedCiv, [], 1.5, "CAN_COLLIDE"];
			_rubbish2 setDir (floor(random 360));


			_flatPos = [_vehPos , 10, 15, 10, 0, 0.3, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;


			_buildings = nearestObjects [_vehPos, BasicBuildings, 100];
			if (count _buildings < 5 && _iteration == 1) then {
				_car1 = createVehicle [selectRandom _vehs, _flatPos, [], 0, "CAN_COLLIDE"];
				_car1 setDamage [1,false];
				_car1 setDir (floor(random 360));
				_objFlame1 = createVehicle ["test_EmptyObjectForFireBig", _flatPos, [], 0, "CAN_COLLIDE"];

			};
		};


		_iteration = _iteration + 1;
	};


};


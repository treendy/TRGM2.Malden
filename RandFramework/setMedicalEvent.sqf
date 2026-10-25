_requiredItemIndex = selectRandom [0,1,2];
requiredItemsCount = [10,5,2] select _requiredItemIndex;
RequestedMedicalItem = ["FirstAidKit","FirstAidKit","Medikit"] select _requiredItemIndex;
RequestedMedicalItemName = ["First Aid Kits","First Aid Kits","Medikit"] select _requiredItemIndex;

if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
	RequestedMedicalItem = ["ACE_bloodIV","ACE_quikclot","ACE_surgicalKit"] select _requiredItemIndex;
	requiredItemsCount = [5,5,2] select _requiredItemIndex;
	RequestedMedicalItemName = ["Blood IV (1000ml)","Basic Field Dressing (QuikClot)","Surgical Kits"] select _requiredItemIndex;
};
publicVariable "requiredItemsCount";
publicVariable "RequestedMedicalItem";
publicVariable "RequestedMedicalItemName";

//use IDAP with police car???

_posOfAO =  _this select 0;


_nearLocations = nearestLocations [_posOfAO, ["NameCity","NameCityCapital","NameVillage"], 2500];
if (!(isNil "IsTraining") || MainIsHidden) then {
	_nearLocations = nearestLocations [_posOfAO, ["NameCity","NameCityCapital","NameVillage"], 30000];
};

_eventLocationPos = nil;
{
	_xLocPos = locationPosition selectRandom _nearLocations;
	if (_xLocPos distance _posOfAO > 1000) then {
		_nearestRoads = _xLocPos nearRoads 150;
		_eventLocationPos = getPos (selectRandom _nearestRoads);
	};
} forEach _nearLocations;
if (isNil("_eventLocationPos")) then {
	_nearestRoads = _posOfAO nearRoads 5000;
	if (!(isNil "IsTraining") || MainIsHidden) then {
		_nearestRoads = _posOfAO nearRoads 30000;		
	};
	_eventLocationPos = getPos (selectRandom _nearestRoads);
};


[_eventLocationPos, 5, 3, 5, 3] call TRGM_fnc_spawnEventThreats;


_iteration = 1;

while {_iteration <= 2} do {

	_roadInfo = [_eventLocationPos, 50, 5] call TRGM_fnc_findRoadWithDirection;
	if (count _roadInfo > 0) then {
		_roadInfo params ["_nearestRoad","_direction"];

		_roadBlockPos =  getPos _nearestRoad;

		_mainVeh = createVehicle [selectRandom Ambulances,_roadBlockPos,[],0,"NONE"];
		_mainVeh setVehicleLock "LOCKED";
		_mainVehDirection =  ([_direction,(selectRandom[0,-10,10,170,180,190])] call TRGM_fnc_AddToDirection);
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

			[getPos _mainVeh, "Medical Situation"] call TRGM_fnc_createEventMarker;
		};

		if (selectRandom [true,false]) then {
			[_mainVeh] spawn TRGM_fnc_eventFlareLoop;
		};

		[_mainVeh] remoteExec ["TRGM_fnc_medicalFlashLights", 0, true];


		_vehPos = getPos _mainVeh;
		_backOfVehArea = _vehPos getPos [5,([_mainVehDirection,(selectRandom[170,180,190])] call TRGM_fnc_AddToDirection)];
		//_direction is direction of road
		//_mainVehDirection is direction of first veh
		//use these to lay down guys, cones, rubbish, barriers, lights etc...

		_group = createGroup civilian; 

		_downedCiv = [_group, selectRandom sCivilian, _backOfVehArea] call TRGM_fnc_createWoundedCasualty;
		_downedCivMedic = [_group, selectRandom Paramedics, _backOfVehArea, _downedCiv] call TRGM_fnc_createTreatingMedic;

		if (_iteration == 1) then {
			[_downedCivMedic, ["Ask if needs assistance",{hint format["Please can you supply us with %1 * %2.  Place them in this vehicle!",requiredItemsCount,RequestedMedicalItemName]},[_downedCivMedic]]] remoteExec ["addAction", 0, true];
			[_mainVeh,_downedCivMedic] spawn {
				_mainVeh = _this select 0;
				_downedCivMedic = _this select 1;
				_completed = false;
				while{(alive _mainVeh && !_completed)} do {
					_itemCount = {RequestedMedicalItem == _x} count (itemcargo _mainVeh);
					if (_itemCount >= requiredItemsCount) then {
						["Thank you, this should help us get things under control"] remoteExecCall ["Hint", 0];
						_completed = true;
						removeAllActions _downedCivMedic;
						[0.3, "Assited with medical emergency"] call TRGM_fnc_adjustMaxBadPoints;
					};
					sleep 2;
				};
			};

			_Crater = createVehicle ["Crater", _backOfVehArea, [], 20, "CAN_COLLIDE"];
			
			_downedCivMedic2 = _group createUnit [selectRandom sCivilian,_backOfVehArea,[],8,"NONE"];
			_downedCivMedic2 playmove "Acts_CivilListening_2";
			_downedCivMedic2 disableAI "anim";  
			_downedCivMedic2 addEventHandler ["killed", {_this spawn TRGM_fnc_ParamedicKilled;}]; //ParamedicKilled

			_downedCiv2 = _group createUnit [selectRandom Paramedics,getpos _downedCivMedic2,[],2,"NONE"];
			_downedCiv2 playmove "Acts_CivilTalking_2";
			_downedCiv2 disableAI "anim";  
			_downedCiv2 addEventHandler ["killed", {_this spawn TRGM_fnc_CivKilled;}]; //ParamedicKilled
			_directionFromMed2ToCiv2 = [_downedCivMedic2, _downedCiv2] call BIS_fnc_DirTo; 
			_downedCivMedic2 setDir _directionFromMed2ToCiv2;	
			_directionFromCiv2ToMed2 = [_downedCiv2, _downedCivMedic2] call BIS_fnc_DirTo; 
			_downedCiv2 setDir _directionFromCiv2ToMed2;	
		};
		if (_iteration == 2) then {
			_downedCiv2 = _group createUnit [selectRandom sCivilian,_backOfVehArea,[],8,"NONE"];
			_downedCiv2 playmove "Acts_CivilHiding_2";
			_downedCiv2 disableAI "anim";  
			_downedCiv2 addEventHandler ["killed", {_this spawn TRGM_fnc_CivKilled;}]; //ParamedicKilled
			_directionFromCiv2ToMed2 = [_downedCiv2, _downedCiv] call BIS_fnc_DirTo; 
			_downedCiv2 setDir _directionFromCiv2ToMed2;	

			_downedCiv3 = _group createUnit [selectRandom sCivilian,_backOfVehArea,[],25,"NONE"];
			_downedCiv3 playmove "Acts_CivilShocked_1";
			_downedCiv3 disableAI "anim";  
			_downedCiv3 setDir (floor(random 360));
			_downedCiv3 addEventHandler ["killed", {_this spawn TRGM_fnc_CivKilled;}]; //ParamedicKilled
		};

		_rubbish1 = createVehicle [selectRandom MedicalMessItems, getpos _downedCiv, [], 1.5, "CAN_COLLIDE"];
		_rubbish1 setDir (floor(random 360));

		_rubbish2 = createVehicle [selectRandom MedicalMessItems, getpos _downedCiv, [], 1.5, "CAN_COLLIDE"];
		_rubbish2 setDir (floor(random 360));

		_medicalBox1 = createVehicle [selectRandom MedicalBoxes, (_downedCiv getpos [2,(floor(random 360))]), [], 0, "CAN_COLLIDE"];
		_medicalBox1 setDir (floor(random 360));
		clearItemCargoGlobal _medicalBox1;


		_nearestRoadsPoint2 = _vehPos nearRoads 25;	
		_roadConnectedTo2 = [];
		_nearestRoad2 = objNull; //declared here so it is still in scope after the if below
		if (count _nearestRoadsPoint2 > 0) then {
			_nearestRoad2 = _nearestRoadsPoint2 select 0;
			_roadConnectedTo2 = roadsConnectedTo _nearestRoad2;
		};
		if (count _roadConnectedTo2 > 0) then {
			_connectedRoad2 = _roadConnectedTo2 select 0;
			_direction2 = [_nearestRoad2, _connectedRoad2] call BIS_fnc_DirTo;	


			_conelight1 = createVehicle [selectRandom ConesWithLight, (_nearestRoad2 getpos [3,[_direction2,90] call TRGM_fnc_AddToDirection]), [], 0, "CAN_COLLIDE"];
			_conelight1 enableSimulation false;
			_conelight1 setDir (floor(random 360));		
			_conelight2 = createVehicle [selectRandom ConesWithLight, (_nearestRoad2 getpos [3,[_direction2,270] call TRGM_fnc_AddToDirection]), [], 0, "CAN_COLLIDE"];
			_conelight2 enableSimulation false;
			_conelight2 setDir (floor(random 360));		
		};

		_flatPos = [_vehPos , 10, 15, 10, 0, 0.3, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;


		_buildings = nearestObjects [_vehPos, BasicBuildings, 100];
		if (count _buildings < 5 && _iteration == 1) then {
			_car1 = createVehicle [selectRandom CivCars, _flatPos, [], 0, "CAN_COLLIDE"];
			_car1 setDamage [1,false];
			_car1 setDir (floor(random 360));
			_objFlame1 = createVehicle ["test_EmptyObjectForFireBig", _flatPos, [], 0, "CAN_COLLIDE"];

		};

		if (_iteration == 1 and selectRandom [true,false]) then {
			_flatPosPolice1 = [_vehPos , 30, 50, 10, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			_carPolice = createVehicle [selectRandom PoliceVehicles, _flatPosPolice1, [], 0, "NONE"];
			_manPolice = createGroup west createUnit [selectRandom Police,getpos _carPolice,[],15,"NONE"];
			_manPolice setDir (floor(random 360));
			_manPolice setBehaviour "SAFE";
		};

		if (_iteration == 1) then {
			_sidePos = getPos _mainVeh;
			_iCount = selectRandom[0,0,0,0,1];
			while {_iCount > 0} do {
				_thisAreaRange = 100;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = true;
					_thisSide = east; 
					_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
					_thisAllowBarakade = true;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,100] spawn TRGM_fnc_setCheckpoint;
				};
			};
			//spawn inner sentry
			_iCount = selectRandom[0,0,0,0,1];
			while {_iCount > 0} do {
				_thisAreaRange = 100;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = false;
					_thisSide = east; 
					_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
					_thisAllowBarakade = false;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,100] spawn TRGM_fnc_setCheckpoint;
				};
			};

		};
	};


	_iteration = _iteration + 1;
};


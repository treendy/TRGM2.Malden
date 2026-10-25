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

_bloodPools = ["BloodPool_01_Large_New_F","BloodSplatter_01_Large_New_F"];

//use IDAP with police car???

fnc_AddToDirection = {
	params ["_origDirection","_addToDirection"];

	_iResult = _origDirection + _addToDirection;
	if (_iResult > 360) then {
		_iResult = _iResult - 360;
	};
	if (_origDirection+_addToDirection < 0) then {
		_iResult = 360 + _iResult ;
	};

	_iResult;
};	


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


if (selectRandom [true,false,false,false,false]) then {
	[_eventLocationPos] spawn TRGM_fnc_createWaitingAmbush;
	if (selectRandom[true,false,false]) then {
		[_eventLocationPos] spawn TRGM_fnc_createWaitingSuicideBomber;
	};
};
if (selectRandom [true,false,false,false,false]) then {
	[_eventLocationPos] spawn TRGM_fnc_createWaitingSuicideBomber;
};
if (selectRandom[true,false,false]) then {
	[_eventLocationPos] spawn TRGM_fnc_createEnemySniper;
};


_thisAreaRange = 50;
_iteration = 1;

while {_iteration <= 2} do {
	if (_iteration == 2) then {
		_thisAreaRange = 50;
	};

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
	if (_PosFound) then {

		_roadBlockPos =  getPos _nearestRoad;
		_roadBlockSidePos = _nearestRoad getPos [10, ([_direction,90] call fnc_AddToDirection)];

		_mainVeh = createVehicle [selectRandom Ambulances,_roadBlockPos,[],0,"NONE"];
		_mainVeh setVehicleLock "LOCKED";
		_mainVehDirection =  ([_direction,(selectRandom[0,-10,10,170,180,190])] call fnc_AddToDirection);
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

			if (MainIsHidden) then {
				//Here... store location and type, so can learn this from intel
			};

			if (!(isNil "IsTraining")) then {
				_markerEventMedi = createMarker [format["_markerEventMedi%1",(call TRGM_fnc_nextMarkerId)], getPos _mainVeh];
				_markerEventMedi setMarkerShape "ICON";
				_markerEventMedi setMarkerType "hd_dot";
				_markerEventMedi setMarkerText "Medical Situation";				
			}	
			else {
				if (selectRandom[true,false,false,false]) then {
					_markerEventMedi = createMarker [format["_markerEventMedi%1",(call TRGM_fnc_nextMarkerId)], getPos _mainVeh];
					_markerEventMedi setMarkerShape "ICON";
					_markerEventMedi setMarkerType "hd_dot";
					_markerEventMedi setMarkerText "Distress Signal";				
				};
			};

		};

if (selectRandom [true,false]) then {
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

		[_mainVeh] remoteExec ["TRGM_fnc_medicalFlashLights", 0, true];


		_vehPos = getPos _mainVeh;
		_backOfVehArea = _vehPos getPos [5,([_mainVehDirection,(selectRandom[170,180,190])] call fnc_AddToDirection)];
		//_direction is direction of road
		//_mainVehDirection is direction of first veh
		//use these to lay down guys, cones, rubbish, barriers, lights etc...

		_group = createGroup civilian; 
		
		_downedCiv = _group createUnit [selectRandom sCivilian,_backOfVehArea,[],0,"NONE"];
		_downedCiv setDamage 0.8;
		[_downedCiv, "Acts_CivilInjuredGeneral_1"] remoteExec ["switchMove", 0];
		_downedCiv disableAI "anim";  
		_downedCivDirection = (floor(random 360));
		_downedCiv setDir (_downedCivDirection);
		_downedCiv addEventHandler ["killed", {_this spawn TRGM_fnc_CivKilled;}];
		_bloodPool1 = createVehicle [selectRandom _bloodPools, getpos _downedCiv, [], 0, "CAN_COLLIDE"];
		_bloodPool1 setDir (floor(random 360));
		if (selectRandom[true]) then {
			_trialDir = (floor(random 360));
			_trialPos = (getPos _bloodPool1) getPos [3,_trialDir];
			_bloodTrail1 = createVehicle ["BloodTrail_01_New_F", _trialPos, [], 0, "CAN_COLLIDE"];
			_bloodTrail1 setDir _trialDir;
		};

		[_downedCiv] spawn {
			_downedCiv = _this select 0;
			while{ (alive _downedCiv)} do {
				[_downedCiv, selectRandom WoundedSounds] remoteExecCall ["say3D", [0,-2] select isDedicated]; //say3D is local, so play it for every player
				sleep selectRandom [2,2.5,3];
			}
			
		};


_downedCivMedic = _group createUnit [selectRandom Paramedics,_backOfVehArea,[],0,"CAN_COLLIDE"];
		_downedCivMedic playmove "Acts_TreatingWounded02";
		_downedCivMedic disableAI "anim";  
		_downedCivMedic attachTo [_downedCiv, [0.5,-0.3,-0.1]];
		_downedCivMedic setDir 270;
		_downedCivMedic addEventHandler ["killed", {_this spawn TRGM_fnc_ParamedicKilled;}]; //ParamedicKilled

		
		[_downedCivMedic] remoteExec ["fncMedicalParamedicLight", 0, true];

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
					sleep selectRandom [2];
				};
			};

			_Crater = createVehicle ["Crater", _backOfVehArea, [], 20, "CAN_COLLIDE"];
			
			_downedCivMedic2 = _group createUnit [selectRandom sCivilian,_backOfVehArea,[],8,"NONE"];
			_downedCivMedic2 playmove "Acts_CivilListening_2";
			_downedCivMedic2 disableAI "anim";  
			_downedCivMedic2 addEventHandler ["killed", {_this spawn TRGM_fnc_ParamedicKilled;}]; //ParamedicKilled

			//_RequestedMedicalItems

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
		if (count _nearestRoadsPoint2 > 0) then {
			_nearestRoad2 = _nearestRoadsPoint2 select 0;
			_roadConnectedTo2 = roadsConnectedTo _nearestRoad2;
		};
		if (count _roadConnectedTo2 > 0) then {
			_connectedRoad2 = _roadConnectedTo2 select 0;
			_direction2 = [_nearestRoad2, _connectedRoad2] call BIS_fnc_DirTo;	


			_conelight1 = createVehicle [selectRandom ConesWithLight, (_nearestRoad2 getpos [3,[_direction2,90] call fnc_AddToDirection]), [], 0, "CAN_COLLIDE"];
			_conelight1 enableSimulation false;
			_conelight1 setDir (floor(random 360));		
			_conelight2 = createVehicle [selectRandom ConesWithLight, (_nearestRoad2 getpos [3,[_direction2,270] call fnc_AddToDirection]), [], 0, "CAN_COLLIDE"];
			_conelight2 enableSimulation false;
			_conelight2 setDir (floor(random 360));		
		};

		_flatPos = nil;
		_flatPos = [_vehPos , 10, 15, 10, 0, 0.3, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;


_buildings = nearestObjects [_vehPos, BasicBuildings, 100];
		if (count _buildings < 5 && _iteration == 1) then {
			_car1 = createVehicle [selectRandom CivCars, _flatPos, [], 0, "CAN_COLLIDE"];
			_car1 setDamage [1,false];
			_car1 setDir (floor(random 360));
			_objFlame1 = createVehicle ["test_EmptyObjectForFireBig", _flatPos, [], 0, "CAN_COLLIDE"];

		};

		if (_iteration == 1 and selectRandom [true,false]) then {
			_flatPosPolice1 = nil;
			_flatPosPolice1 = [_vehPos , 30, 50, 10, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			_carPolice = createVehicle [selectRandom PoliceVehicles, _flatPosPolice1, [], 0, "NONE"];
			_manPolice = createGroup west createUnit [selectRandom Police,getpos _carPolice,[],15,"NONE"];
			_manPolice setDir (floor(random 360));
			_manPolice setBehaviour "SAFE";
	//Police

		};
		//CivCars

		//ConesWithLight
		//Cones
		//Paramedics
		//"MedicalGarbage_01_Bandage_F" createVehicle getpos player; 
		if (_iteration == 1) then {
			_sidePos = getPos _mainVeh;
			_iCount = selectRandom[0,0,0,0,1];
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 100;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = nil;
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
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 100;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = nil;
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



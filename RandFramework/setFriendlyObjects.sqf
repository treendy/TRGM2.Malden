_MergedLoudoutData = LoadoutData + "#" + LoadoutDataDefault;
_tempAddedObjects = [];

_chrLineBreak = "
"; // <<< no idea how to find the ascii or char value that i can use to split a string on line breaks... this works for now
_chrTab = "	";
if (_MergedLoudoutData != "") then {
	//hint "test3";
	_errorMessage = "";
	_Roles = _MergedLoudoutData splitString "#";
	{
		_RoleDetails = _x splitString ":";
		_roleType = _RoleDetails select 0;
		_roleType = _roleType splitString " " joinString ""; 
		_roleType = _roleType splitString _chrLineBreak joinString ""; 		
		_roleType = _roleType splitString _chrTab joinString ""; 		
		if (_roleType == "OtherObjects") then {
			_loadoutoptions = (_RoleDetails select 1) splitString ";";
			{
				_line = _x splitString "=";
				_name = _line select 0;
				_object = _line select 1;
				if (!isNil "_name" && !isNil "_object") then {
					_name = _name splitString " " joinString ""; 
					_name = _name splitString _chrLineBreak joinString ""; 		
					_name = _name splitString _chrTab joinString "";
					_object = _object splitString " " joinString ""; 
					_object = _object splitString _chrLineBreak joinString ""; 		
					_object = _object splitString _chrTab joinString ""; 	
					if ("[" in (_object splitSTring "")) then { //convert to array
						_object = _object splitString " " joinString ""; 
						_object = _object splitString """" joinString "";
						_object = _object splitString "[" joinString "";
						_object = _object splitString "]" joinString "";
						_object = _object splitString ",";
					};
					if (!(_name in _tempAddedObjects)) then {
						_tempAddedObjects pushBack _name;
						switch (_name) do {
							case "AirSupport1" : {			
								_pos = getPos airSup1;
								_dir = getDir airSup1;
								deleteVehicle airSup1;
								sleep 0.01;
								airSup1 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								airSup1 setDir _dir;
								airSup1 allowDamage false;
								airSup1 setPos (_pos vectorAdd [0,0,0.1]);
								airSup1 allowDamage true;
							};
							case "AirSupport2" : {			
								_pos = getPos airSup2;
								_dir = getDir airSup2;
								deleteVehicle airSup2;
								sleep 0.01;
								airSup2 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								airSup2 setDir _dir;
								airSup2 allowDamage false;
								airSup2 setPos (_pos vectorAdd [0,0,0.1]);
								airSup2 allowDamage true;
							};
							case "ArmoredCar" : {			
								_pos = getPos car1;
								_dir = getDir car1;
								deleteVehicle car1;
								sleep 0.01;
								car1 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								car1 setDir _dir;
								car1 allowDamage false;
								car1 setPos (_pos vectorAdd [0,0,0.1]);
								car1 allowDamage true;
							};
							case "TankorAPC" : {			
								_pos = getPos tank1;
								_dir = getDir tank1;
								deleteVehicle tank1;
								sleep 0.01;
								tank1 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								tank1 setDir _dir;
								tank1 allowDamage false;
								tank1 setPos (_pos vectorAdd [0,0,0.1]);
								tank1 allowDamage true;
							};
							case "UnarmedCar" : {			
								_pos = getPos k1car2;
								_dir = getDir k1car2;
								deleteVehicle k1car2;
								sleep 0.01;
								k1car2 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								k1car2 setDir _dir;
								k1car2 allowDamage false;
								k1car2 setPos (_pos vectorAdd [0,0,0.1]);
								k1car2 allowDamage true;
							};
							case "MedicalTruck" : {			
								_pos = getPos medTruck;
								_dir = getDir medTruck;
								deleteVehicle medTruck;
								sleep 0.01;
								medTruck = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								medTruck setDir _dir;
								medTruck allowDamage false;
								medTruck setPos (_pos vectorAdd [0,0,0.1]);
								medTruck allowDamage true;
							};
							case "MedicalChopper" : {			
								_pos = getPos mediChop1;
								_dir = getDir mediChop1;
								deleteVehicle mediChop1;
								sleep 0.01;
								mediChop1 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								mediChop1 setDir _dir;
								mediChop1 allowDamage false;
								mediChop1 setPos (_pos vectorAdd [0,0,0.1]);
								mediChop1 allowDamage true;
							};
							case "LargeTransportChopper" : {			
								_pos = getPos chin1;
								_dir = getDir chin1;
								deleteVehicle chin1;
								sleep 0.01;
								chin1 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								chin1 setDir _dir;
								chin1 allowDamage false;
								chin1 setPos (_pos vectorAdd [0,0,0.1]);
								chin1 allowDamage true;
							};
							case "FuelTruck" : {			
								_pos = getPos Fuel1;
								_dir = getDir Fuel1;
								deleteVehicle Fuel1;
								sleep 0.01;
								Fuel1 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								Fuel1 setDir _dir;
								_pos = getPos Fuel2;
								_dir = getDir Fuel2;
								deleteVehicle Fuel2;
								sleep 0.01;
								Fuel2 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								Fuel2 setDir _dir;
								Fuel2 allowDamage false;
								Fuel2 setPos (_pos vectorAdd [0,0,0.1]);
								Fuel2 allowDamage true;
							};
							case "RepairTruck" : {			
								_pos = getPos RepairTruck;
								_dir = getDir RepairTruck;
								deleteVehicle RepairTruck;
								sleep 0.01;
								RepairTruck = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								RepairTruck setDir _dir;
								RepairTruck allowDamage false;
								RepairTruck setPos (_pos vectorAdd [0,0,0.1]);
								RepairTruck allowDamage true;
							};
							case "AmmoTruck" : {			
								_pos = getPos AmmoTruck;
								_dir = getDir AmmoTruck;
								deleteVehicle AmmoTruck;
								sleep 0.01;
								AmmoTruck = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								AmmoTruck setDir _dir;
								AmmoTruck allowDamage false;
								AmmoTruck setPos (_pos vectorAdd [0,0,0.1]);
								AmmoTruck allowDamage true;
							};
							case "SmallHeli" : {			
								_pos = getPos SmallHeli1;
								_dir = getDir SmallHeli1;
								deleteVehicle SmallHeli1;
								sleep 0.01;
								SmallHeli1 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								SmallHeli1 setDir _dir;
								_pos = getPos SmallHeli2;
								_dir = getDir SmallHeli2;
								deleteVehicle SmallHeli2;
								sleep 0.01;
								SmallHeli2 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								SmallHeli2 setDir _dir;
								_pos = getPos SmallHeli3;
								_dir = getDir SmallHeli3;
								deleteVehicle SmallHeli3;
								sleep 0.01;
								SmallHeli3 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								SmallHeli3 setDir _dir;
							};
							case "AITransportChopper" : {
								_pos = getPos chopper1;
								_dir = getDir chopper1;
								{deleteVehicle _x;}forEach crew chopper1;
								deleteVehicle chopper1;
								sleep 0.01;
								chopper1 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								createVehicleCrew chopper1; 
								chopper1 allowDamage false;
								chopper1 setDir _dir;
								chopper1 allowDamage false; 
								chopper1 setCaptive true;
								chopper1 disableAI "AUTOTARGET"; 
							    chopper1 disableAI "TARGET"; 
							    chopper1 disableAI "SUPPRESSION"; 
							    chopper1 disableAI "AUTOCOMBAT";
								chopper1 setBehaviour "SAFE";		
								publicVariable "chopper1";							
							};
							case "AIExtractSupuportChopper" : {
								_pos = getPos chopper2;
								_dir = getDir chopper2;
								{deleteVehicle _x;}forEach crew chopper2;
								deleteVehicle chopper2;
								sleep 0.01;
								chopper2 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								chopper2 setDir _dir;
								chopper2 allowDamage false;
								chopper2 setPos (_pos vectorAdd [0,0,0.1]);
								chopper2 allowDamage true;
								chopper2 allowDamage false;
								createVehicleCrew chopper2; 
							};
							case "FriendlyScoutVehicles" : {
								FriendlyScoutVehicles = _object;
							};
							case "FriendlyCheckpointUnits" : {
								FriendlyCheckpointUnits = _object;
							};
							case "FriendlyFastResponseVehicles" : {
								FriendlyFastResponseVehicles = _object;
							};
							case "SupplySupportChopperOptions" : {
								SupplySupportChopperOptions = _object;
								supReqSupDrop setVariable ['BIS_SUPP_vehicles',SupplySupportChopperOptions,true];
							};
							case "AirSupportOptions" : {
								AirSupportOptions = _object;
								supReqAirSup setVariable ['BIS_SUPP_vehicles',AirSupportOptions,true];
							};
							case "ArtiSupportOptions" : {
								ArtiSupportOptions = _object;
								SupProArti setVariable ['BIS_SUPP_vehicles',ArtiSupportOptions,true];
								//_pos = getPos AIArti1;
								//_dir = getDir AIArti1;
								//{deleteVehicle _x;}forEach crew AIArti1;
								//deleteVehicle AIArti1;
								//sleep 0.01;
								//AIArti1 = createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"];
								//AIArti1 setDir _dir;
								//AIArti1 allowDamage false;
								//AIArti1 setPos (_pos vectorAdd [0,0,0.1]);
								//AIArti1 allowDamage true;
								//createVehicleCrew AIArti1; 
								//SupProArti synchronizeObjectsAdd [AIArti1];
								//AIArti1 addEventHandler ["fired", "if (_this select 1 == 'mortar_155mm_AMOS') then {[0.1,'Arti round fired'] execVM 'RandFramework\AdjustBadPoints.sqf';hint ""Arti round fired"";AIArti1 setVehicleAmmo 1;};"]; 
							};

							
						};
					};
				};
			} forEach _loadoutoptions;
		};
	} forEach _Roles;
	if (_errorMessage != "") then {
		hint  _errorMessage;
	};
};




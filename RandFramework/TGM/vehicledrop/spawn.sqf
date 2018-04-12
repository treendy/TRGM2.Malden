//[getPos player, 100, "B_supplyCrate_F"] call TGM_vd_fnc_spawn;
private ["_iniVeh","_para","_pos","_height","_type"];

_pos = _this select 0;
_height = _this select 1;
_type = _this select 2;

bDoDrop = false; publicVariable "bDoDrop";

hint (localize "STR_TRGM2_vehicledrop_spawn_VehicleDrop");


_groupp1 = createGroup west;


	_airSup1Array = [[(position player select 0)-1500,(position player select 1)-1500], 45, FriendlyVehDropAir, _groupp1] call Bis_fnc_spawnvehicle;
	airDropFriend1 = _airSup1Array select 0;
	airDropFriend1 flyInHeight 40;
	//airSup1 setpos [getposATL airSup1 select 0, getposATL airSup1 select 1, 40];
	airDropFriend1 allowDamage false;
	airDropFriend1 enableAttack false;
	airDropFriend1 setBehaviour "CARELESS";
	airDropFriend1 setCombatMode "BLUE";
	airDropFriend1 disableAi "TARGET";
	airDropFriend1 disableAi "AUTOTARGET";
	airDropFriend1 disableAi "FSM";
	airDropFriend1 setCaptive true;


_v1wp1 =_groupp1 addWaypoint [[(_pos select 0)-1500,(position player select 1)-1500], 0];
[_groupp1, 0] setWaypointStatements ["true", "airDropFriend1 flyInHeight _height;"];
[_groupp1, 0] setWaypointSpeed "FULL";
[_groupp1, 0] setWaypointBehaviour "COMBAT";
//[_groupp1, 0] setWaypointType "MOVE";


_v1wp2 =_groupp1 addWaypoint [_pos, 0];
[_groupp1, 1] setWaypointStatements ["true", "airDropFriend1 flyInHeight _height;"];
[_groupp1, 1] setWaypointSpeed "FULL";
//[_groupp1, 1] setWaypointType "MOVE";


_v1wp3 =_groupp1 addWaypoint [[(_pos select 0)+50000,(position player select 1)+50000], 0];
[_groupp1, 2] setWaypointStatements ["true", "airDropFriend1 flyInHeight _height; hint ""Paradrop complete""; bDoDrop = true; publicVariable ""bDoDrop""; "];
[_groupp1, 2] setWaypointSpeed "FULL";
//[_groupp1, 1] setWaypointType "MOVE";

while {!bDoDrop} do {
	 sleep 1;
};

hint "asdfasdfasd";
bDoDrop = false;

//hint "Paradrop complete";

sleep 1;

_iniVeh = createVehicle[_type, [0, 0, 10000], [], 0, "NONE"];
_para = "B_Parachute_02_F" createVehicle [0, 0, 10000];
_iniVeh attachTo [_para,[0,0,-1]];
_para setPos [_pos select 0, _pos select 1, _height];
[_iniVeh, _para, _type] spawn TGM_vd_fnc_handle;
_iniVeh;
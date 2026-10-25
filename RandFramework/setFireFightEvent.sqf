
_posOfAO =  _this select 0;
_eventType = _this select 1; //1=fullWar  2=AOOnly  3=WarzoneOnly 4=warzoneOnlyFullWar

_nearLocations = nearestLocations [_posOfAO, ["NameCity","NameCityCapital","NameVillage"], 1500];

_eventLocationPos = nil;
if (!isNil("ForceWarZoneLoc")) then {
	_eventLocationPos = _posOfAO;
}
else {
	{
		_xLocPos = locationPosition _x;
		if (_xLocPos distance _posOfAO > 950) then {
			_eventLocationPos = _xLocPos;
		};
	} forEach _nearLocations;


	if (isNil("_eventLocationPos")) then {
		_buildings = nearestObjects [_posOfAO, BasicBuildings, 2000];
		{
			_xLocPos = position _x;
			_bIsClearFromAOCamp = true;
			if (!isNil "AOCampPos") then {
				if (_xLocPos distance AOCampPos < 500) then {
					_bIsClearFromAOCamp = false;
				};
			};
			if (_xLocPos distance _posOfAO > 950 && _bIsClearFromAOCamp) then {
				_eventLocationPos = _xLocPos;
			};
		} forEach _buildings;
	};
};

if (isNil("_eventLocationPos")) exitWith {}; //no suitable location found for the warzone


//sTeamleader
//sRifleman
//sMachineGunMan
//sTank3Tank

//TankorAPC
//FriendlyCheckpointUnits


WarzonePos = _eventLocationPos;

if (_eventType == 1 || _eventType == 3 || _eventType == 4) then {
	_mrkEnemy = createMarker ["mrkWarzoneEnemy", _eventLocationPos];
	_mrkEnemy setMarkerText "!!WARNING!! KEEP CLEAR";
	_mrkEnemy setMarkerShape "ICON";
	_mrkEnemy setMarkerColor "ColorEAST";
	_mrkEnemy setMarkerType "mil_warning";

	_mrkFriendlyPos = _eventLocationPos getPos [200 * sqrt random 1, random 360];
	_mrkFriendly = createMarker ["mrkWarzoneFriendly", _mrkFriendlyPos];
	_mrkFriendly setMarkerShape "ICON";
	_mrkFriendlyDir = [_mrkFriendlyPos, _eventLocationPos] call BIS_fnc_DirTo;
	_mrkFriendly setMarkerDir _mrkFriendlyDir;
	_mrkFriendly setMarkerColor "ColorWEST";
	_mrkFriendly setMarkerType "mil_arrow2";
};


if (selectRandom[true,false] || _eventType == 1 || _eventType == 4) then {
	_flatPos1 =  _eventLocationPos getPos [100 * sqrt random 1, random 360];
	_flatPos1 = [_eventLocationPos , 0, 100, 8, 0, 0.5, 0,[],[_flatPos1,_flatPos1]] call BIS_fnc_findSafePos;
	tracer1 setPos _flatPos1;

	_flatPos2 =  _eventLocationPos getPos [100 * sqrt random 1, random 360];
	_flatPos2 = [_eventLocationPos , 0, 100, 8, 0, 0.5, 0,[],[_flatPos2,_flatPos2]] call BIS_fnc_findSafePos;
	tracer2 setPos _flatPos2;

	_flatPos3 =  _eventLocationPos getPos [100 * sqrt random 1, random 360];
	_flatPos3 = [_eventLocationPos , 0, 100, 8, 0, 0.5, 0,[],[_flatPos3,_flatPos3]] call BIS_fnc_findSafePos;
	tracer3 setPos _flatPos3;

	_flatPos4 =  _eventLocationPos getPos [100 * sqrt random 1, random 360];
	_flatPos4 = [_eventLocationPos , 0, 100, 8, 0, 0.5, 0,[],[_flatPos4,_flatPos4]] call BIS_fnc_findSafePos;
	tracer4 setPos _flatPos4;

};

WarEventActive = true;

[_eventLocationPos] spawn {
	_eventLocationPos = _this select 0;
	while {WarEventActive} do {
		_type = selectRandom ["Bomb_03_F","Missile_AA_04_F","M_Mo_82mm_AT_LG"];
		_xPos = (_eventLocationPos select 0)-125;
		_yPos = (_eventLocationPos select 1)-125;


		if (selectRandom[true,false,false,false,false,false,false]) then {
			_li_aaa = _type createVehicleLocal [_xPos+(random 250),_yPos+(random 250),0];
			_li_aaa setDamage 1;
		}
		else {

			_group = createGroup east;
			_sUnitType = selectRandom [sRiflemanToUse,sMachineGunManToUse];
			_tempFireUnit = _group createUnit [_sUnitType,[_xPos+(random 250),_yPos+(random 250),0],[],0,"NONE"];
			hideObject _tempFireUnit;  
			sleep 1;
			_shotsToFire = selectRandom[3,10,15];
			_weapon = currentWeapon _tempFireUnit;
			_sleep = selectRandom [0.05,0.1];
			while {_shotsToFire > 0} do {
				_tempFireUnit forceWeaponFire [_weapon, "FullAuto"];
				_shotsToFire = _shotsToFire - 1;
				sleep _sleep;
			};
		
			deleteVehicle _tempFireUnit;
			deleteGroup _group;
		};

		_sleep = 1+(random 6);
		_diceRoll = floor(random 12)+1;

		if (_diceRoll == 1) then {_sleep = 10+random 5};
		if (_diceRoll > 6) then {_sleep = 0.5+random 1};

		sleep _sleep;
	  };
};

[_eventLocationPos] spawn {
	_eventLocationPos = _this select 0;

	while {WarEventActive} do {

		waitUntil {bAndSoItBegins && CustomObjectsSet && PlayersHaveLeftStartingArea};

		_AirToUse = selectRandom FriendlyJet;
		_NoOfVeh = selectRandom [1,2];
		_bSetCaptive = selectRandom [true,true,true,false];
		if (selectRandom [true,false,false]) then {
			_AirToUse = selectRandom FriendlyChopper;
		};
		_pos = _eventLocationPos getPos [3000,random 360];//random 360 and 3 clicks out and no playable units within 2 clicks
		_pos = [_pos select 0,_pos select 1, 365];
		_dir = [_pos, _eventLocationPos] call BIS_fnc_DirTo;//dir from pos to _eventLocationPos
		_WarzoneGroupp1 = createGroup west;
		for "_i" from 1 to _NoOfVeh do {
			_spawnPos = _pos;
			if (_i > 1) then {_spawnPos = _pos getPos [30,random 360];};
			_WarZoneAir = ([_spawnPos, _dir, _AirToUse, _WarzoneGroupp1] call Bis_fnc_spawnvehicle) select 0;
			_WarZoneAir flyInHeight 45;
			_WarZoneAir setBehaviour "CARELESS";
			_WarZoneAir setSpeedMode "FULL";
			_WarZoneAir doMove (_pos getPos [60000,_dir]);
			_WarZoneAir setCaptive _bSetCaptive;

			//delete the aircraft and its crew once it is far enough away
			[_WarZoneAir,_eventLocationPos] spawn {
				_veh = _this select 0;
				_eventLocationPos = _this select 1;
				while {alive _veh} do {
					_curDist = _veh distance _eventLocationPos;
					if (_curDist > 4000) then {
						_grp = group driver _veh;
						{_veh deleteVehicleCrew _x} forEach crew _veh;
						deleteVehicle _veh;
						if (count units _grp == 0) then {deleteGroup _grp};
					};
					sleep 5;
				};
			};
		};
		
		sleep selectRandom [240,480];
		
	};
};



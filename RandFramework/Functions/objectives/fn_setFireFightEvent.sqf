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
			//hint str(_xLocPos distance _posOfAO);
		};
	} forEach _nearLocations;


	if (isNil("_eventLocationPos")) then {
		_buildings = nearestObjects [_posOfAO, TREND_BasicBuildings, 2000];
		{
			_xLocPos = position _x;
			_bIsClearFromAOCamp = true;
			if (!isNil "TREND_AOCampPos") then {
				if (_xLocPos distance TREND_AOCampPos < 500) then {
					_bIsClearFromAOCamp = false;
				};
			};
			if (_xLocPos distance _posOfAO > 950 && _bIsClearFromAOCamp) then {
				_eventLocationPos = _xLocPos;
			};
		} forEach _buildings;
	};
};

if (isNil("_eventLocationPos")) then {_eventType == 2};


//sTeamleader
//sRifleman
//sMachineGunMan
//sTank3Tank

//TankorAPC
//FriendlyCheckpointUnits

//TESTTESTeventLocationPos = _eventLocationPos;

TREND_WarzonePos = _eventLocationPos;

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


_objPos = _eventLocationPos getPos [100 * sqrt random 1, random 360];
//_Obj1 = "land_helipadempty_f" createVehicle _objPos;
//nul = [_Obj1] execVM "RandFramework\Alias\ALambientbattle\alias_flaks.sqf";

/*if (selectRandom[true,false] || _eventType == 1 || _eventType == 4) then {
	_objPos = _eventLocationPos getPos [100 * sqrt random 1, random 360];
	_Obj8  = "land_helipadempty_f" createVehicle _objPos;
	null = [_Obj8,false] execVM "RandFramework\Alias\ALambientbattle\aaa_search_light.sqf";

	_objPos = _eventLocationPos getPos [100 * sqrt random 1, random 360];
	_Obj9  = "land_helipadempty_f" createVehicle _objPos;
	null = [_Obj9,false] execVM "RandFramework\Alias\ALambientbattle\aaa_search_light.sqf";
};*/
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

_mainAOPos = TREND_ObjectivePossitions select 0;

if (_eventType == 1 || _eventType == 2) then {
	//_objPos = _mainAOPos getPos [100 * sqrt random 1, random 360];
	//_Obj10  = "land_helipadempty_f" createVehicle _objPos;
	//nul = [_Obj10] execVM "RandFramework\Alias\ALambientbattle\alias_flaks.sqf";
};

/*
WarColor = ppEffectCreate ["colorCorrections", 1550];
//WarColor ppEffectAdjust [1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.7], [0.9, 0.9, 0.9, 0.0]];
WarColor ppEffectAdjust [1, 0.8, -0.001, [0.0, 0.0, 0.0, 0.0], [0.8*2, 0.5*2, 0.0, 0.92], [0.9, 0.9, 0.9, 0.0]];
WarColor ppEffectCommit 0;
WarColor ppEffectCommit 0;

WarGrain = ppEffectCreate ["FilmGrain", 2050];
WarGrain ppEffectEnable true;
WarGrain ppEffectAdjust [0.02, 1, 1, 0.1, 1, false];
WarGrain ppEffectCommit 0;

WarColor ppEffectEnable true;
WarGrain ppEffectEnable true;
*/

TREND_WarEventActive = true;

[_eventLocationPos] spawn {
	_eventLocationPos = _this select 0;
	while {TREND_WarEventActive} do {
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
			_ammo = _tempFireUnit ammo _weapon;
			_sleep = selectRandom [0.05,0.1];
			while {_shotsToFire > 0} do {
				_tempFireUnit forceWeaponFire [_weapon, "FullAuto"];
				_shotsToFire = _shotsToFire - 1;
				sleep _sleep;
			};

			deleteVehicle _tempFireUnit;
		};

		_sleep = 1+(random 6);
		_diceRoll = floor(random 12)+1;

		if (_diceRoll == 1) then {_sleep = 10+random 5};
		if (_diceRoll > 6) then {_sleep = 0.5+random 1};
		//hint str(_sleep);

		sleep _sleep;
	  };
};

[_eventLocationPos] spawn {
	_eventLocationPos = _this select 0;

	while {TREND_WarEventActive} do {

		waitUntil {TREND_bAndSoItBegins && TREND_CustomObjectsSet && TREND_PlayersHaveLeftStartingArea};

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
		_WarZoneAir1 = [_pos, _dir, _AirToUse, _WarzoneGroupp1] call Bis_fnc_spawnvehicle;
		(_WarZoneAir1 select 0) flyInHeight 45;
		(_WarZoneAir1 select 0) setBehaviour "CARELESS";
		(_WarZoneAir1 select 0) setSpeedMode "FULL";
		(_WarZoneAir1 select 0) doMove (_pos getPos [60000,_dir]);
		(_WarZoneAir1 select 0) setCaptive _bSetCaptive;
		_WarZoneAir2 = nil;
		if (_NoOfVeh > 1) then {
			_pos2 = _pos getPos [30,random 360];
			_WarZoneAir2 = [_pos2, _dir, _AirToUse, _WarzoneGroupp1] call Bis_fnc_spawnvehicle;
			(_WarZoneAir2 select 0) flyInHeight 45;
			(_WarZoneAir2 select 0) setBehaviour "CARELESS";
			(_WarZoneAir2 select 0) setSpeedMode "FULL";
			(_WarZoneAir2 select 0) doMove (_pos getPos [60000,_dir]);
			(_WarZoneAir2 select 0) setCaptive _bSetCaptive;
		};

		[(_WarZoneAir1 select 0),_eventLocationPos] spawn {
			_veh = _this select 0;
			_eventLocationPos = _this select 1;
			while {alive _veh} do {
				_curDist = _veh distance _eventLocationPos;
				if (_curDist > 4000) then {
					{_veh deleteVehicleCrew _x} forEach crew _veh;
					deleteVehicle _veh;
				};
			};
		};

		if (_NoOfVeh > 1) then {
			[(_WarZoneAir2 select 0),_eventLocationPos] spawn {
				_veh = _this select 0;
				_eventLocationPos = _this select 1;
				while {alive _veh} do {
					_curDist = _veh distance _eventLocationPos;
					if (_curDist > 4000) then {
						{_veh deleteVehicleCrew _x} forEach crew _veh;
						deleteVehicle _veh;
					};
				};
			};
		};

		sleep selectRandom [240,480];

	};
};



/*
{nul = [99999,true] execVM "RandFramework\RikoSandStorm\ROSSandstorm.sqf";} remoteExec ["call", 0];
*/

/*
 	WarColor ppEffectEnable false;
 	ppEffectDestroy WarColor;

    WarGrain ppEffectEnable false;
    ppEffectDestroy WarGrain;
*/


true;
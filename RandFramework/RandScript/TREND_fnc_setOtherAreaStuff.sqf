//included only to reset the s*ToUse unit classes (AO population may have switched them to militia) before the events below use them
#include "trendFunctions.sqf";


_mainObjPos = ObjectivePossitions select 0;


if (bDebugMode) then {["Mission Events: Comms 10"] remoteExec ["systemChat", 0];};

//Check if radio tower is near
//Land_TTowerBig_2_F    Land_TTowerBig_1_F       Land_Communication_F       Land_TBox_F
//_TowerBuilding = selectRandom TowerBuildings;
_TowersNear = nearestObjects [_mainObjPos, TowerBuildings, TowerRadius];


if (bDebugMode) then {["Mission Events: Comms 9"] remoteExec ["systemChat", 0];};
{
	[_x, [localize "STR_TRGM2_TRENDfncsetOtherAreaStuff_CheckEnemyComms","RandFramework\checkForComms.sqf",[_x]]] remoteExec ["addAction", 0, true];
} forEach _TowersNear;
if (count _TowersNear > 0) then {
	if (bDebugMode) then {["Mission Events: Comms 8"] remoteExec ["systemChat", 0];};
	TowerBuild = _TowersNear select 0;
	TowerClassName = typeOf TowerBuild;
	publicVariable "TowerBuild";
	_TowerX = position TowerBuild select 0;
	_TowerY = position TowerBuild select 1;
	_distanceHQ = getMarkerPos "mrkHQ" distance [_TowerX, _TowerY];
	if (bDebugMode) then {["Mission Events: Comms 7"] remoteExec ["systemChat", 0];};
	if (_distanceHQ > 1400) then {
		bHasCommsTower = true;
		CommsTowerPos = [_TowerX, _TowerY];
		publicVariable "bHasCommsTower";
		publicVariable "CommsTowerPos";
		if (selectRandom[true]) then {
			_PatrolDist = 70;
			_wayX = _TowerX;
			_wayY = _TowerY;
			_wp1PosTower = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
			_wp2PosTower = [ _wayX + _PatrolDist, _wayY - _PatrolDist, 0];
			_wp3PosTower = [ _wayX - _PatrolDist, _wayY - _PatrolDist, 0];
			_wp4PosTower = [ _wayX - _PatrolDist, _wayY + _PatrolDist, 0];
			_wp5PosTower = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];

			if (bDebugMode) then {["Mission Events: Comms 6"] remoteExec ["systemChat", 0];};
			if (!(surfaceIsWater _wp1PosTower) && !(surfaceIsWater _wp2PosTower) && !(surfaceIsWater _wp3PosTower) && !(surfaceIsWater _wp4PosTower)) then {
				if (bDebugMode) then {["Mission Events: Comms 5"] remoteExec ["systemChat", 0];};
				//1 in (_maxGroups*2) chance of having an AA/AT guy

				_DiamPatrolGroupTower = createGroup east;
					if selectRandom [true,false] then {
						sAAMan createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
					}
					else {
						sATMan createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
					};

				sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
				if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
				if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
				if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
				if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};

				_DiamPatrolGroupTower addWaypoint [_wp1PosTower, 0];
				_DiamPatrolGroupTower addWaypoint [_wp2PosTower, 0];
				_DiamPatrolGroupTower addWaypoint [_wp3PosTower, 0];
				_DiamPatrolGroupTower addWaypoint [_wp4PosTower, 0];
				_DiamPatrolGroupTower addWaypoint [_wp5PosTower, 0];
				[_DiamPatrolGroupTower, 0] setWaypointSpeed "LIMITED";
				[_DiamPatrolGroupTower, 0] setWaypointBehaviour "SAFE";
				[_DiamPatrolGroupTower, 1] setWaypointSpeed "LIMITED";
				[_DiamPatrolGroupTower, 1] setWaypointBehaviour "SAFE";
				[_DiamPatrolGroupTower, 4] setWaypointType "CYCLE";
				_DiamPatrolGroupTower setBehaviour "SAFE";
			};
			if (bDebugMode) then {["Mission Events: Comms 4"] remoteExec ["systemChat", 0];};

		};


		if (selectRandom [true,true,true]) then {
			if (bDebugMode) then {["Mission Events: Comms 3"] remoteExec ["systemChat", 0];};

			_trg = createTrigger ["EmptyDetector", position TowerBuild, false];
			_trg setVariable ["DelMeOnNewCampaignDay",true];
			_trg setTriggerArea [100, 100, 0, false];
			_sSTringPos = format["%1,%2", position TowerBuild select 0, position TowerBuild select 1];
			_sTriggerString = "!alive(nearestObject [[" + _sSTringPos + "], '" + TowerClassName + "'])";

			_trg setTriggerStatements [_sTriggerString, "bCommsBlocked = true; publicVariable ""bCommsBlocked""; [this] execVM ""RandFramework\RandScript\commsBlocked.sqf"";", ""];

			publicVariable "TowerBuild";
			if (bDebugMode) then {["Mission Events: Comms 2"] remoteExec ["systemChat", 0];};
		};
		if (bDebugMode) then {["Mission Events: Comms 1"] remoteExec ["systemChat", 0];};

	};
};

if (bDebugMode) then {["Mission Events: CommsEND"] remoteExec ["systemChat", 0];};


if (!(isNil "IsTraining")) then {
	[_mainObjPos] spawn TRGM_fnc_setMedicalEvent;
	[_mainObjPos] spawn TRGM_fnc_setMedicalEvent;

	[_mainObjPos] spawn TRGM_fnc_setDownedChopperEvent;
	[_mainObjPos] spawn TRGM_fnc_setDownedChopperEvent;

	[_mainObjPos] spawn TRGM_fnc_setDownConvoyEvent;
	[_mainObjPos] spawn TRGM_fnc_setDownConvoyEvent;

	[_mainObjPos] spawn TRGM_fnc_setDownCivCarEvent;
	[_mainObjPos] spawn TRGM_fnc_setDownCivCarEvent;
	[_mainObjPos] spawn TRGM_fnc_setDownCivCarEvent;

	[_mainObjPos,20000,true,false,nil, true] spawn TRGM_fnc_setTargetEvent;
	[_mainObjPos,20000,true,false,nil, true] spawn TRGM_fnc_setTargetEvent;
	[_mainObjPos,20000,true,false,nil, true] spawn TRGM_fnc_setTargetEvent;
	[_mainObjPos,20000,true,false,nil, true] spawn TRGM_fnc_setTargetEvent;

}
else {


	//[function, params, chance (selectRandom of it decides if the event is spawned)], debug messages count down from 15 to 0 as before
	private _fireFightPos = _mainObjPos;
	private _fireFightChance = ChanceOfOccurance;
	if (!isNil "ForceWarZoneLoc") then {
		_fireFightPos = ForceWarZoneLoc;
		_fireFightChance = [true];
	};
	//these IEDs are more likely to show (instead of using ChanceOfOccurance), as a lot of times, these are not a trap, just an empty vehicle or a pile of rubbish
	private _iedChance = [true,true,false];
	private _events = [
		[TRGM_fnc_setTargetEvent, [_mainObjPos,1900,false,false,nil, false], ChanceOfOccurance],
		[TRGM_fnc_setTargetEvent, [_mainObjPos,1900,false,false,nil, true], ChanceOfOccurance],
		[TRGM_fnc_setATMineEvent, [_mainObjPos], ChanceOfOccurance],
		[TRGM_fnc_setDownCivCarEvent, [_mainObjPos], ChanceOfOccurance],
		[TRGM_fnc_setATMineEvent, [_mainObjPos], ChanceOfOccurance],
		[TRGM_fnc_setFireFightEvent, [_fireFightPos,4], _fireFightChance],
		[TRGM_fnc_setMedicalEvent, [_mainObjPos], ChanceOfOccurance],
		[TRGM_fnc_setDownedChopperEvent, [_mainObjPos], ChanceOfOccurance],
		[TRGM_fnc_setDownConvoyEvent, [_mainObjPos], ChanceOfOccurance],
		[TRGM_fnc_setDownCivCarEvent, [_mainObjPos], ChanceOfOccurance],
		[TRGM_fnc_setIEDEvent, [_mainObjPos], _iedChance],
		[TRGM_fnc_setIEDEvent, [_mainObjPos], _iedChance],
		[TRGM_fnc_setIEDEvent, [_mainObjPos], _iedChance],
		[TRGM_fnc_setIEDEvent, [_mainObjPos], _iedChance],
		[TRGM_fnc_setIEDEvent, [_mainObjPos], _iedChance],
		[TRGM_fnc_setIEDEvent, [_mainObjPos], _iedChance]
	];
	{
		_x params ["_eventFnc", "_eventParams", "_eventChance"];
		if (bDebugMode) then {[format["Loading Events : %1", (count _events) - 1 - _forEachIndex]] remoteExec ["systemChat", 0];};
		if (selectRandom _eventChance) then {
			_eventParams spawn _eventFnc;
			sleep 1;
		};
	} forEach _events;

if (bDebugMode) then {["Loading Events : END"] remoteExec ["systemChat", 0];};
};

//worldName call BIS_fnc_mapSize << equals the width in meters
//altis is 30720
//kujari is 16384 wide
//STratis is 8192
_mapSizeTxt = "LARGE";
_mapSize = worldName call BIS_fnc_mapSize;
if (_mapSize < 13000) then {
	_mapSizeTxt = "MEDIUM"
};
if (_mapSize < 10000) then {
	_mapSizeTxt = "SMALL"
};

if (IsFullMap) then {
	if (bDebugMode) then {["Loading Full Map Events : BEGIN"] remoteExec ["systemChat", 0];};
	[_mainObjPos,true] spawn TRGM_fnc_setDownCivCarEvent;
	[_mainObjPos,true] spawn TRGM_fnc_setDownedChopperEvent;
	[_mainObjPos,true] spawn TRGM_fnc_setATMineEvent;
	[_mainObjPos,2000,false,false,nil,nil,true] spawn TRGM_fnc_setIEDEvent;
	[_mainObjPos,2000,false,false,nil,nil,true] spawn TRGM_fnc_setIEDEvent;

	if (_mapSizeTxt == "MEDIUM" || _mapSizeTxt == "LARGE") then {
		[_mainObjPos,2000,false,false,nil,nil,true] spawn TRGM_fnc_setIEDEvent;
		[_mainObjPos,2000,false,false,nil,nil,true] spawn TRGM_fnc_setIEDEvent;
		[_mainObjPos,true] spawn TRGM_fnc_setATMineEvent;
	};
	if (_mapSizeTxt == "LARGE") then {
		[_mainObjPos,true] spawn TRGM_fnc_setDownCivCarEvent;
		[_mainObjPos,true] spawn TRGM_fnc_setDownedChopperEvent;
		[_mainObjPos,2000,false,false,nil,nil,true] spawn TRGM_fnc_setIEDEvent;
	};

	if (bDebugMode) then {["Loading Full Map Events : END"] remoteExec ["systemChat", 0];};

};
//chance of a convey, start somewhere random, parked up and ready to move, wait random time, then start driving to location
// chance that players may get notified when convey leave.... if destroyed, gain 0.3 rep
// if player is notificed, then have tracking on convey and show on map (important, as if it gets stuck, player will be waiting for nothing)



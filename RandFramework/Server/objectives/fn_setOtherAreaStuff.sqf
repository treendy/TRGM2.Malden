///*orangestest

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
_mainObjPos = TRGM_VAR_ObjectivePossitions select 0;


["Mission Events: Comms 10", true] call TRGM_GLOBAL_fnc_log;

//Check if radio tower is near
_Towers = nearestObjects [_mainObjPos, TRGM_VAR_TowerBuildings, TRGM_VAR_TowerRadius];
_Towers = _Towers + nearestTerrainObjects [_mainObjPos, ["TRANSMITTER"], TRGM_VAR_TowerRadius, false];
_TowersNear = [];
{
	if !(typeOf _x isEqualTo "") then {
		_TowersNear pushBackUnique _x;
	}
} forEach _Towers;

["Mission Events: Comms 9", true] call TRGM_GLOBAL_fnc_log;
if (count _TowersNear > 0) then {
	["Mission Events: Comms 8", true] call TRGM_GLOBAL_fnc_log;
	TRGM_VAR_TowerBuild = selectRandom _TowersNear;
	publicVariable "TRGM_VAR_TowerBuild";
	[TRGM_VAR_TowerBuild, [localize "STR_TRGM2_TRENDfncsetOtherAreaStuff_CheckEnemyComms",{[TRGM_VAR_IntelShownType, "CommsTower"] spawn TRGM_GLOBAL_fnc_showIntel;},[TRGM_VAR_TowerBuild]]] remoteExec ["addAction", 0, true];
	TRGM_VAR_TowerClassName = typeOf TRGM_VAR_TowerBuild;
	publicVariable "TRGM_VAR_TowerBuild";
	_TowerX = position TRGM_VAR_TowerBuild select 0;
	_TowerY = position TRGM_VAR_TowerBuild select 1;
	_distanceHQ = getMarkerPos "mrkHQ" distance [_TowerX, _TowerY];

	_towerMarkrer = createMarker [format["_markerEnemyComms%1",(floor(random 360))], [_TowerX, _TowerY]];
	_towerMarkrer setMarkerShape "ICON";
	_towerMarkrer setMarkerType "hd_unknown";
	_towerMarkrer setMarkerText "Intel";

	["Mission Events: Comms 7", true] call TRGM_GLOBAL_fnc_log;
	if (_distanceHQ > TRGM_VAR_SideMissionMinDistFromBase) then {
		TRGM_VAR_bHasCommsTower =  true; publicVariable "TRGM_VAR_bHasCommsTower";
		TRGM_VAR_CommsTowerPos =  [_TowerX, _TowerY]; publicVariable "TRGM_VAR_CommsTowerPos";
		if (true) then {
			_PatrolDist = 70;
			_wayX = _TowerX;
			_wayY = _TowerY;
			_wp1PosTower = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
			_wp2PosTower = [ _wayX + _PatrolDist, _wayY - _PatrolDist, 0];
			_wp3PosTower = [ _wayX - _PatrolDist, _wayY - _PatrolDist, 0];
			_wp4PosTower = [ _wayX - _PatrolDist, _wayY + _PatrolDist, 0];
			_wp5PosTower = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];

			["Mission Events: Comms 6", true] call TRGM_GLOBAL_fnc_log;
			if (!(surfaceIsWater _wp1PosTower) && !(surfaceIsWater _wp2PosTower) && !(surfaceIsWater _wp3PosTower) && !(surfaceIsWater _wp4PosTower)) then {
				["Mission Events: Comms 5", true] call TRGM_GLOBAL_fnc_log;
				//1 in (_maxGroups*2) chance of having an AA/AT guy

				_DiamPatrolGroupTower = createGroup east;
					if (random 1 < .50) then {
						(call sAAManToUse) createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
						_iHasAA = 1;
					}
					else {
						(call sATManToUse) createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
						_iHasAT = 1;
					};

				(call sRiflemanToUse) createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
				if (random 1 < .50) then {(call sRiflemanToUse) createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
				if (random 1 < .50) then {(call sRiflemanToUse) createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
				if (random 1 < .50) then {(call sRiflemanToUse) createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
				if (random 1 < .50) then {(call sRiflemanToUse) createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};

				_wp1Tower = _DiamPatrolGroupTower addWaypoint [_wp1PosTower, 0];
				_wp2Tower = _DiamPatrolGroupTower addWaypoint [_wp2PosTower, 0];
				_wp3Tower = _DiamPatrolGroupTower addWaypoint [_wp3PosTower, 0];
				_wp4Tower = _DiamPatrolGroupTower addWaypoint [_wp4PosTower, 0];
				_wp5Tower = _DiamPatrolGroupTower addWaypoint [_wp5PosTower, 0];
				[_DiamPatrolGroupTower, 0] setWaypointSpeed "LIMITED";
				[_DiamPatrolGroupTower, 0] setWaypointBehaviour "SAFE";
				[_DiamPatrolGroupTower, 1] setWaypointSpeed "LIMITED";
				[_DiamPatrolGroupTower, 1] setWaypointBehaviour "SAFE";
				[_DiamPatrolGroupTower, 4] setWaypointType "CYCLE";
				_DiamPatrolGroupTower setBehaviour "SAFE";
			};
			["Mission Events: Comms 4", true] call TRGM_GLOBAL_fnc_log;

		};


		if (true) then {
			["Mission Events: Comms 3", true] call TRGM_GLOBAL_fnc_log;

			_trg = createTrigger ["EmptyDetector", position TRGM_VAR_TowerBuild];
			_trg setVariable ["DelMeOnNewCampaignDay",true];
			_trg setTriggerArea [100, 100, 0, false];
			_sSTringPos = format["%1,%2", position TRGM_VAR_TowerBuild select 0, position TRGM_VAR_TowerBuild select 1];
			_sTriggerString = "!alive(nearestObject [[" + _sSTringPos + "], '" + TRGM_VAR_TowerClassName + "'])";

			_trg setTriggerStatements [_sTriggerString, "TRGM_VAR_bCommsBlocked = true; publicVariable ""TRGM_VAR_bCommsBlocked""; [this] spawn TRGM_SERVER_fnc_commsBlocked;", ""];
			["Mission Events: Comms 2", true] call TRGM_GLOBAL_fnc_log;
		};
		["Mission Events: Comms 1", true] call TRGM_GLOBAL_fnc_log;

	};
};

["Mission Events: CommsEND", true] call TRGM_GLOBAL_fnc_log;

if (!(isNil "IsTraining")) then {
	[_mainObjPos] spawn TRGM_SERVER_fnc_setMedicalEvent;
	[_mainObjPos] spawn TRGM_SERVER_fnc_setMedicalEvent;

	[_mainObjPos] spawn TRGM_SERVER_fnc_setDownedChopperEvent;
	[_mainObjPos] spawn TRGM_SERVER_fnc_setDownedChopperEvent;

	[_mainObjPos] spawn TRGM_SERVER_fnc_setDownConvoyEvent;
	[_mainObjPos] spawn TRGM_SERVER_fnc_setDownConvoyEvent;

	[_mainObjPos] spawn TRGM_SERVER_fnc_setDownCivCarEvent;
	[_mainObjPos] spawn TRGM_SERVER_fnc_setDownCivCarEvent;
	[_mainObjPos] spawn TRGM_SERVER_fnc_setDownCivCarEvent;

	[_mainObjPos,20000,true,false,nil, true] spawn TRGM_SERVER_fnc_setTargetEvent;
	[_mainObjPos,20000,true,false,nil, true] spawn TRGM_SERVER_fnc_setTargetEvent;
	[_mainObjPos,20000,true,false,nil, true] spawn TRGM_SERVER_fnc_setTargetEvent;
	[_mainObjPos,20000,true,false,nil, true] spawn TRGM_SERVER_fnc_setTargetEvent;

}
else {


["Loading Events : 15", true] call TRGM_GLOBAL_fnc_log;
	if (selectRandom TRGM_VAR_ChanceOfOccurance) then {
		[_mainObjPos,1900,false,false,nil, false] spawn TRGM_SERVER_fnc_setTargetEvent;
		sleep 1;
	};

["Loading Events : 14", true] call TRGM_GLOBAL_fnc_log;
	if (selectRandom TRGM_VAR_ChanceOfOccurance) then {
		[_mainObjPos,1900,false,false,nil, true] spawn TRGM_SERVER_fnc_setTargetEvent;
		sleep 1;
	};

["Loading Events : 13", true] call TRGM_GLOBAL_fnc_log;
	if (selectRandom TRGM_VAR_ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setATMineEvent;
		sleep 1;
	};

["Loading Events : 12", true] call TRGM_GLOBAL_fnc_log;
	if (selectRandom TRGM_VAR_ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setDownCivCarEvent;
		sleep 1;
	};

["Loading Events : 11", true] call TRGM_GLOBAL_fnc_log;
	if (selectRandom TRGM_VAR_ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setATMineEvent;
		sleep 1;
	};
["Loading Events : 10", true] call TRGM_GLOBAL_fnc_log;
	if (selectRandom TRGM_VAR_ChanceOfOccurance || !isNil("TRGM_VAR_ForceWarZoneLoc")) then {
	//if (true) then {
		//_eventType = selectRandom[4]; //1=fullWar  2=AOOnly  3=WarzoneOnly  4=warzoneOnlyFullWar (only set to warzone now... was strange over AO... maybe at some point in future can stop flak when player near AO)
		if (!isNil("TRGM_VAR_ForceWarZoneLoc")) then {
			[TRGM_VAR_ForceWarZoneLoc,4] spawn TRGM_SERVER_fnc_setFireFightEvent;
		}
		else {
			[_mainObjPos,4] spawn TRGM_SERVER_fnc_setFireFightEvent;
		};
		sleep 1;
	};
["Loading Events : 9", true] call TRGM_GLOBAL_fnc_log;
	if (selectRandom TRGM_VAR_ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setMedicalEvent;
		sleep 1;
	};
["Loading Events : 8", true] call TRGM_GLOBAL_fnc_log;
	if (selectRandom TRGM_VAR_ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setDownedChopperEvent;
		sleep 1;
	};
["Loading Events : 7", true] call TRGM_GLOBAL_fnc_log;
	if (selectRandom TRGM_VAR_ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setDownConvoyEvent;
		sleep 1;
	};
["Loading Events : 6", true] call TRGM_GLOBAL_fnc_log;
	if (selectRandom TRGM_VAR_ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setDownCivCarEvent;
		sleep 1;
	};



//these are more likely to show (instead of using TRGM_VAR_ChanceOfOccurance), as a lot of times, these are not a trap, just an empty vehicle or a pile of rubbish
["Loading Events : 5", true] call TRGM_GLOBAL_fnc_log;
	if (random 1 < .66) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setIEDEvent;
		sleep 1;
	};
["Loading Events : 4", true] call TRGM_GLOBAL_fnc_log;
	if (random 1 < .66) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setIEDEvent;
		sleep 1;
	};
["Loading Events : 3", true] call TRGM_GLOBAL_fnc_log;
	if (random 1 < .66) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setIEDEvent;
		sleep 1;
	};
["Loading Events : 2", true] call TRGM_GLOBAL_fnc_log;
	if (random 1 < .66) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setIEDEvent;
		sleep 1;
	};
["Loading Events : 1", true] call TRGM_GLOBAL_fnc_log;
	if (random 1 < .66) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setIEDEvent;
		sleep 1;
	};
["Loading Events : 0", true] call TRGM_GLOBAL_fnc_log;
	if (random 1 < .66) then {
		[_mainObjPos] spawn TRGM_SERVER_fnc_setIEDEvent;
		sleep 1;
	};





["Loading Events : END", true] call TRGM_GLOBAL_fnc_log;
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

if (TRGM_VAR_IsFullMap) then {
	["Loading Full Map Events : BEGIN", true] call TRGM_GLOBAL_fnc_log;
	[_mainObjPos,true] spawn TRGM_SERVER_fnc_setDownCivCarEvent;
	[_mainObjPos,true] spawn TRGM_SERVER_fnc_setDownedChopperEvent;
	[_mainObjPos,true] spawn TRGM_SERVER_fnc_setATMineEvent;
	[_mainObjPos,2000,false,false,nil,nil,true] spawn TRGM_SERVER_fnc_setIEDEvent;
	[_mainObjPos,2000,false,false,nil,nil,true] spawn TRGM_SERVER_fnc_setIEDEvent;

	if (_mapSizeTxt isEqualTo "MEDIUM" || _mapSizeTxt isEqualTo "LARGE") then {
		[_mainObjPos,2000,false,false,nil,nil,true] spawn TRGM_SERVER_fnc_setIEDEvent;
		[_mainObjPos,2000,false,false,nil,nil,true] spawn TRGM_SERVER_fnc_setIEDEvent;
		[_mainObjPos,true] spawn TRGM_SERVER_fnc_setATMineEvent;
	};
	if (_mapSizeTxt isEqualTo "LARGE") then {
		[_mainObjPos,true] spawn TRGM_SERVER_fnc_setDownCivCarEvent;
		[_mainObjPos,true] spawn TRGM_SERVER_fnc_setDownedChopperEvent;
		[_mainObjPos,2000,false,false,nil,nil,true] spawn TRGM_SERVER_fnc_setIEDEvent;
	};

	["Loading Full Map Events : END", true] call TRGM_GLOBAL_fnc_log;

};
//chance of a convey, start somewhere random, parked up and ready to move, wait random time, then start driving to location
// chance that players may get notified when convey leave.... if destroyed, gain 0.3 rep
// if player is notificed, then have tracking on convey and show on map (important, as if it gets stuck, player will be waiting for nothing)



//orangestest*/
true;
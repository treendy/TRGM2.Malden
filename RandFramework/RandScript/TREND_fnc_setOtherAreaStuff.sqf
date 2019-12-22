#include "../../setUnitGlobalVars.sqf";
#include "trendFunctions.sqf";

///*orangestest

_mainObjPos = ObjectivePossitions select 0;


{systemChat "Mission Events: Comms 10";} remoteExec ["bis_fnc_call", 0];

//Check if radio tower is near
//Land_TTowerBig_2_F    Land_TTowerBig_1_F       Land_Communication_F       Land_TBox_F
//_TowerBuilding = selectRandom TowerBuildings;
_TowersNear = nearestObjects [_mainObjPos, TowerBuildings, TowerRadius];



{systemChat "Mission Events: Comms 9";} remoteExec ["bis_fnc_call", 0];
{
	[[_x, [localize "STR_TRGM2_TRENDfncsetOtherAreaStuff_CheckEnemyComms","RandFramework\checkForComms.sqf",[_x]]],"addAction",true,true] call BIS_fnc_MP;
} forEach _TowersNear;
if (count _TowersNear > 0) then {
//if (!(isNull _pepe)) then {
	{systemChat "Mission Events: Comms 8";} remoteExec ["bis_fnc_call", 0];
	TowerBuild = _TowersNear select 0;
	TowerClassName = typeOf TowerBuild;
	publicVariable "TowerBuild";
	_TowerX = position TowerBuild select 0;
	_TowerY = position TowerBuild select 1;
	_distanceHQ = getMarkerPos "mrkHQ" distance [_TowerX, _TowerY];
	{systemChat "Mission Events: Comms 7";} remoteExec ["bis_fnc_call", 0];
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

			{systemChat "Mission Events: Comms 6";} remoteExec ["bis_fnc_call", 0];
			if (!(surfaceIsWater _wp1PosTower) && !(surfaceIsWater _wp2PosTower) && !(surfaceIsWater _wp3PosTower) && !(surfaceIsWater _wp4PosTower)) then {
				{systemChat "Mission Events: Comms 5";} remoteExec ["bis_fnc_call", 0];
				//1 in (_maxGroups*2) chance of having an AA/AT guy

				_DiamPatrolGroupTower = createGroup east;
					if selectRandom [true,false] then {
						sAAMan createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
						_iHasAA = 1;
					}
					else {
						sATMan createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
						_iHasAT = 1;
					};

				sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
				if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
				if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
				if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
				if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};

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
			{systemChat "Mission Events: Comms 4";} remoteExec ["bis_fnc_call", 0];

		};


		if (selectRandom [true,true,true]) then {
			{systemChat "Mission Events: Comms 3";} remoteExec ["bis_fnc_call", 0];

			_trg = createTrigger ["EmptyDetector", position TowerBuild];
			_trg setVariable ["DelMeOnNewCampaignDay",true];
			_trg setTriggerArea [100, 100, 0, false];
			_sSTringPos = format["%1,%2", position TowerBuild select 0, position TowerBuild select 1];
			_sTriggerString = "!alive(nearestObject [[" + _sSTringPos + "], '" + TowerClassName + "'])";

			_trg setTriggerStatements [_sTriggerString, "bCommsBlocked = true; publicVariable ""bCommsBlocked""; [this] execVM ""RandFramework\RandScript\commsBlocked.sqf"";", ""];

			publicVariable "TowerBuild";
			{systemChat "Mission Events: Comms 2";} remoteExec ["bis_fnc_call", 0];
		};
		{systemChat "Mission Events: Comms 1";} remoteExec ["bis_fnc_call", 0];

	};
};

{systemChat "Mission Events: CommsEND";} remoteExec ["bis_fnc_call", 0];



if (!(isNil "IsTraining")) then {
	[_mainObjPos] execVM "RandFramework\setMedicalEvent.sqf";
	[_mainObjPos] execVM "RandFramework\setMedicalEvent.sqf";

	[_mainObjPos] execVM "RandFramework\setDownedChopperEvent.sqf";
	[_mainObjPos] execVM "RandFramework\setDownedChopperEvent.sqf";

	[_mainObjPos] execVM "RandFramework\setDownConvoyEvent.sqf";
	[_mainObjPos] execVM "RandFramework\setDownConvoyEvent.sqf";

	[_mainObjPos] execVM "RandFramework\setDownCivCarEvent.sqf";
	[_mainObjPos] execVM "RandFramework\setDownCivCarEvent.sqf";
	[_mainObjPos] execVM "RandFramework\setDownCivCarEvent.sqf";

	[_mainObjPos,20000,true,false,nil, true] execVM "RandFramework\setTargetEvent.sqf";
	[_mainObjPos,20000,true,false,nil, true] execVM "RandFramework\setTargetEvent.sqf";
	[_mainObjPos,20000,true,false,nil, true] execVM "RandFramework\setTargetEvent.sqf";
	[_mainObjPos,20000,true,false,nil, true] execVM "RandFramework\setTargetEvent.sqf";

}
else {


{systemChat "Loading Events : 15";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom ChanceOfOccurance) then {
		[_mainObjPos,1900,false,false,nil, false] execVM "RandFramework\setTargetEvent.sqf";
		sleep 1;
	};	

{systemChat "Loading Events : 14";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom ChanceOfOccurance) then {
		[_mainObjPos,1900,false,false,nil, true] execVM "RandFramework\setTargetEvent.sqf";
		sleep 1;
	};	

{systemChat "Loading Events : 13";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setATMineEvent.sqf";
		sleep 1;
	};

{systemChat "Loading Events : 12";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setDownCivCarEvent.sqf";
		sleep 1;
	};	

{systemChat "Loading Events : 11";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setATMineEvent.sqf";
		sleep 1;
	};
{systemChat "Loading Events : 10";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom ChanceOfOccurance || !isNil("ForceWarZoneLoc")) then {
	//if (true) then {
		//_eventType = selectRandom[4]; //1=fullWar  2=AOOnly  3=WarzoneOnly  4=warzoneOnlyFullWar (only set to warzone now... was strange over AO... maybe at some point in future can stop flak when player near AO)
		if (!isNil("ForceWarZoneLoc")) then {
			[ForceWarZoneLoc,4] execVM "RandFramework\setFireFightEvent.sqf";
		}
		else {
			[_mainObjPos,4] execVM "RandFramework\setFireFightEvent.sqf";
		};
		sleep 1;
	};
{systemChat "Loading Events : 9";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setMedicalEvent.sqf";
		sleep 1;
	};
{systemChat "Loading Events : 8";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setDownedChopperEvent.sqf";
		sleep 1;
	};		
{systemChat "Loading Events : 7";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setDownConvoyEvent.sqf";
		sleep 1;
	};		
{systemChat "Loading Events : 6";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setDownCivCarEvent.sqf";
		sleep 1;
	};	

	

//these are more likely to show (instead of using ChanceOfOccurance), as a lot of times, these are not a trap, just an empty vehicle or a pile of rubbish
{systemChat "Loading Events : 5";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom [true,true,false]) then {
		[_mainObjPos] execVM "RandFramework\setIEDEvent.sqf";
		sleep 1;
	};
{systemChat "Loading Events : 4";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom [true,true,false]) then {
		[_mainObjPos] execVM "RandFramework\setIEDEvent.sqf";
		sleep 1;
	};
{systemChat "Loading Events : 3";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom [true,true,false]) then {
		[_mainObjPos] execVM "RandFramework\setIEDEvent.sqf";
		sleep 1;
	};
{systemChat "Loading Events : 2";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom [true,true,false]) then {
		[_mainObjPos] execVM "RandFramework\setIEDEvent.sqf";
		sleep 1;
	};
{systemChat "Loading Events : 1";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom [true,true,false]) then {
		[_mainObjPos] execVM "RandFramework\setIEDEvent.sqf";
		sleep 1;
	};
{systemChat "Loading Events : 0";} remoteExec ["bis_fnc_call", 0];
	if (selectRandom [true,true,false]) then {
		[_mainObjPos] execVM "RandFramework\setIEDEvent.sqf";
		sleep 1;
	};


	


{systemChat "Loading Events : END";} remoteExec ["bis_fnc_call", 0];
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
	{systemChat "Loading Full Map Events : BEGIN";} remoteExec ["bis_fnc_call", 0];
	[_mainObjPos,true] execVM "RandFramework\setDownCivCarEvent.sqf";
	[_mainObjPos,true] execVM "RandFramework\setDownedChopperEvent.sqf";
	[_mainObjPos,true] execVM "RandFramework\setATMineEvent.sqf";
	[_mainObjPos,2000,false,false,nil,nil,true] execVM "RandFramework\setIEDEvent.sqf";
	[_mainObjPos,2000,false,false,nil,nil,true] execVM "RandFramework\setIEDEvent.sqf";

	if (_mapSizeTxt == "MEDIUM" || _mapSizeTxt == "LARGE") then {
		[_mainObjPos,2000,false,false,nil,nil,true] execVM "RandFramework\setIEDEvent.sqf";
		[_mainObjPos,2000,false,false,nil,nil,true] execVM "RandFramework\setIEDEvent.sqf";
		[_mainObjPos,true] execVM "RandFramework\setATMineEvent.sqf";
	};
	if (_mapSizeTxt == "LARGE") then {
		[_mainObjPos,true] execVM "RandFramework\setDownCivCarEvent.sqf";
		[_mainObjPos,true] execVM "RandFramework\setDownedChopperEvent.sqf";
		[_mainObjPos,2000,false,false,nil,nil,true] execVM "RandFramework\setIEDEvent.sqf";
	};

	{systemChat "Loading Full Map Events : END";} remoteExec ["bis_fnc_call", 0];

};
//chance of a convey, start somewhere random, parked up and ready to move, wait random time, then start driving to location
// chance that players may get notified when convey leave.... if destroyed, gain 0.3 rep
// if player is notificed, then have tracking on convey and show on map (important, as if it gets stuck, player will be waiting for nothing)



//orangestest*/

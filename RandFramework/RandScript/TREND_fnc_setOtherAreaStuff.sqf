#include "../../setUnitGlobalVars.sqf";
#include "trendFunctions.sqf";



_mainObjPos = ObjectivePossitions select 0;

//Check if radio tower is near
//Land_TTowerBig_2_F    Land_TTowerBig_1_F       Land_Communication_F       Land_TBox_F
//_TowerBuilding = selectRandom TowerBuildings;
_TowersNear = nearestObjects [_mainObjPos, TowerBuildings, TowerRadius];




{
	[[_x, [localize "STR_TRGM2_TRENDfncsetOtherAreaStuff_CheckEnemyComms","RandFramework\checkForComms.sqf",[_x]]],"addAction",true,true] call BIS_fnc_MP;
} forEach _TowersNear;
if (count _TowersNear > 0) then {
//if (!(isNull _pepe)) then {

	TowerBuild = _TowersNear select 0;
	TowerClassName = typeOf TowerBuild;
	publicVariable "TowerBuild";
	_TowerX = position TowerBuild select 0;
	_TowerY = position TowerBuild select 1;
	_distanceHQ = getMarkerPos "mrkHQ" distance [_TowerX, _TowerY];
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


			if (!(surfaceIsWater _wp1PosTower) && !(surfaceIsWater _wp2PosTower) && !(surfaceIsWater _wp3PosTower) && !(surfaceIsWater _wp4PosTower)) then {
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

		};


		if (selectRandom [true,true,true]) then {

			_trg = createTrigger ["EmptyDetector", position TowerBuild];
			_trg setVariable ["DelMeOnNewCampaignDay",true];
			_trg setTriggerArea [100, 100, 0, false];
			_sSTringPos = format["%1,%2", position TowerBuild select 0, position TowerBuild select 1];
			_sTriggerString = "!alive(nearestObject [[" + _sSTringPos + "], '" + TowerClassName + "'])";

			_trg setTriggerStatements [_sTriggerString, "bCommsBlocked = true; publicVariable ""bCommsBlocked""; [this] execVM ""RandFramework\RandScript\commsBlocked.sqf"";", ""];

			publicVariable "TowerBuild";
		};


	};
};


//if (selectRandom ChanceOfOccurance) then {
if (false) then {
	//change this, not camp, have parked ammo/fuel/repair vehicls like medicalevent, and if vehicles destroyed, gain 0.3 rep  (supply convoy at rest)
	//[_mainObjPos] execVM "RandFramework\setRestingConvoyEvent.sqf";
	_flatPos = nil;
	_flatPos = [_mainObjPos , 200, 2000, 4, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if (str(_flatPos) != "[0,0,0]") then {

		_groupCamp1 = createGroup east;

		_aaaX = _flatPos select 0;
		_aaaY = _flatPos select 1;


		if (surfaceIsWater [_aaaX,_aaaY]) then {
			[[_aaaX,_aaaY], (floor random 175+1), sBoatUnit, _groupCamp1] call bis_fnc_spawnvehicle;

		}
		else {
			sTeamleader createUnit [[_aaaX+1, _aaaY], _groupCamp1];
			sRifleman createUnit [[_aaaX, _aaaY+1], _groupCamp1];
			sRifleman createUnit [[_aaaX+1, _aaaY+1], _groupCamp1];
			sRifleman createUnit [[_aaaX-1, _aaaY], _groupCamp1];
			sRifleman createUnit [[_aaaX, _aaaY-1], _groupCamp1];
			_camp = "FirePlace_burning_F" createVehicle [_aaaX,_aaaY];
		};
	};
};



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

}
else {

	/*!!!MEDICAL EVENT!!!*/
	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setMedicalEvent.sqf";
	};



	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setDownedChopperEvent.sqf";

	};		



	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setDownConvoyEvent.sqf";
	};		

	if (selectRandom ChanceOfOccurance) then {
	//if (true) then {
		[_mainObjPos] execVM "RandFramework\setDownCivCarEvent.sqf";
	};		

};


//chance of a convey, start somewhere random, parked up and ready to move, wait random time, then start driving to location
// chance that players may get notified when convey leave.... if destroyed, gain 0.3 rep
// if player is notificed, then have tracking on convey and show on map (important, as if it gets stuck, player will be waiting for nothing)





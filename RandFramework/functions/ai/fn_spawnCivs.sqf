//Spawns civilians (or friendly rebels when _bIsRebels) in buildings around a position, each group walking between buildings
params ["_sidePos", "_distFromCent", "_bIsRebels"];

private _allBuildings = nearestObjects [_sidePos, BasicBuildings, _distFromCent];

private _unitCount = count _allBuildings;
if (_unitCount > 10) then {
	_unitCount = 10;
};

private _iCount = 0;
private _bRebelLeaderPicked = false;
while {_iCount <= _unitCount} do
{
	//spanwn civ in random building pos
	_randBuilding = selectRandom _allBuildings;
	_sInitString = "";

	if (selectRandom[true,false,false,false,false]) then {

		if (_bIsRebels) then {				
				_sInitString = "this spawn TRGM_fnc_BadReb;";		

		}
		else {
			_sInitString = "[this] spawn TRGM_fnc_badCivInitialize; removeHeadgear this;Removevest this;";
		};
	}
	else {
		if (_bIsRebels) then {
			if (!_bRebelLeaderPicked) then {
				_sInitString = "this addaction [localize ""STR_TRGM2_trendFunctions_TalkToLeader"",""RandFramework\TalkRebLead.sqf"", nil,1.5,true,true,"""",""true"",5]; this addEventHandler [""killed"", {_this spawn TRGM_fnc_InsKilled;}]; removeHeadgear this;";
				_bRebelLeaderPicked = true;
			}
			else {
				_sInitString = "this addEventHandler [""killed"", {_this spawn TRGM_fnc_InsKilled;}]; removeHeadgear this;Removevest this;";
			};
		}
		else {
			_sInitString = "this addEventHandler [""killed"", {_this spawn TRGM_fnc_CivKilled;}]; this addaction [localize ""STR_TRGM2_civillians_fnbadCivAddSearchAction_Button"",""RandFramework\SearchGoodCiv.sqf"", nil,1.5,true,true,"""",""true"",5]; removeHeadgear this;Removevest this;";
		};
	};
	_sideCivGroup = if (_bIsRebels) then {createGroup west} else {createGroup Civilian};
	_allBuildingPos = _randBuilding buildingPos -1;

	if (_bIsRebels) then {
		_wayPosInit = selectRandom _allBuildingPos;
		if (!isNil "_wayPosInit") then {
			_SpawnedRifleman = (_sideCivGroup createUnit [sRiflemanFriendInsurg, _wayPosInit, [], 10, "NONE"]);
			[_SpawnedRifleman] joinSilent (_sideCivGroup);
			if (!_bRebelLeaderPicked) then {
				[_SpawnedRifleman, [localize "STR_TRGM2_trendFunctions_TalkToLeader","RandFramework\TalkRebLead.sqf"]] remoteExec ["addAction", 0, true]; //this runs on the server, players need the action
				_SpawnedRifleman addEventHandler ["killed", {_this spawn TRGM_fnc_InsKilled;}];
				removeHeadgear _SpawnedRifleman;
				_bRebelLeaderPicked = true;
			}
			else {
				_SpawnedRifleman addEventHandler ["killed", {_this spawn TRGM_fnc_InsKilled;}];

				_SpawnedRifleman spawn TRGM_fnc_BadReb;

				Removevest _SpawnedRifleman;
				removeHeadgear _SpawnedRifleman;
				_SpawnedRifleman setVariable ["IsRebel", true, true];
				_bRebelLeaderPicked = true;
			};

		};
	}
	else {
		_wayPosInit = selectRandom _allBuildingPos;
		if (!isNil "_wayPosInit") then {
			_sCivClass = sCivilian;
			if (typeName _sCivClass == "ARRAY") then {
				_sCivClass = selectRandom sCivilian;
			};
			_sCivClass createUnit [_wayPosInit, _sideCivGroup, _sInitString];
		};
	};

	//set waypoints to other buildings
	_iCountWaypoints = 0;
	while {_iCountWaypoints <= 4} do
	{
		_randBuilding2 = selectRandom _allBuildings; //pick one building from our buildings array
		_wayPos = selectRandom (_randBuilding2 buildingPos -1); //nil if the building has no positions
		if (!isNil "_wayPos") then {
			_sideCivGroup addWaypoint [_wayPos, 0];
		};

		[_sideCivGroup, _iCountWaypoints] setWaypointSpeed "LIMITED";
		[_sideCivGroup, _iCountWaypoints] setWaypointBehaviour "SAFE";
		if (_iCountWaypoints == 4) then{[_sideCivGroup, 8] setWaypointType "CYCLE";};
		_iCountWaypoints = _iCountWaypoints + 1;
	};
	_sideCivGroup setBehaviour "SAFE";

	_iCount = _iCount + 1;
};

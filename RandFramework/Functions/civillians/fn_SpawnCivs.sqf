params ["_sidePos", "_distFromCent", "_bIsRebels"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_allBuildings = nil;
_allBuildings = nearestObjects [_sidePos, TREND_BasicBuildings, _distFromCent];

_unitCount = count _allBuildings;
if (_unitCount > 10) then {
	_unitCount = 10;
};

_iCount = 0; //_unitCount
_randBuilding = nil;

_bAllCivsBad = random 1 < .25;

_bRebelLeaderPicked = false;
while {_iCount <= _unitCount} do
{
	//spanwn civ in random building pos
	_randBuilding = selectRandom _allBuildings;
	_sInitString = "";

	if (random 1 < .20) then {

		if (_bIsRebels) then {
				_sInitString = "this spawn TREND_fnc_badReb;";

		}
		else {
			_sInitString = "this spawn TREND_fnc_BadCiv; this addAction [localize ""STR_TRGM2_civillians_fnbadCivAddSearchAction_Button"",{[_this select 0, _this select 1] spawn TREND_fnc_badCivSearch;}, nil,1.5,true,true,"""",""true"",5]; removeHeadgear this;Removevest this;";
		};
	}
	else {
		if (_bIsRebels) then {
			if (!_bRebelLeaderPicked) then {
				_sInitString = "this addaction [localize ""STR_TRGM2_trendFunctions_TalkToLeader"",{[_this select 0, _this select 1] spawn TREND_fnc_TalkRebLead;}, nil,1.5,true,true,"""",""true"",5]; this addEventHandler [""killed"", {_this spawn TREND_fnc_InsKilled;}]; removeHeadgear this;";
				_bRebelLeaderPicked = true;
			}
			else {
				_sInitString = "this addEventHandler [""killed"", {_this spawn TREND_fnc_InsKilled;}]; removeHeadgear this;Removevest this;";
			};
		}
		else {
			_sInitString = "this addEventHandler [""killed"", {_this spawn TREND_fnc_CivKilled;}]; this addaction [localize ""STR_TRGM2_civillians_fnbadCivAddSearchAction_Button"",{[_this select 0, _this select 1] spawn TREND_fnc_SearchGoodCiv;}, nil,1.5,true,true,"""",""true"",5]; removeHeadgear this;Removevest this;";
		};
	};
	_sideCivGroup = nil;
	if (_bIsRebels) then {
		_sideCivGroup = createGroup west;
	}
	else {
		_sideCivGroup = createGroup Civilian;
	};
	_allBuildingPos = _randBuilding buildingPos -1;

	if (_bIsRebels) then {
		_wayPosInit = selectRandom _allBuildingPos;
		if (!isNil "_wayPosInit") then {
			//_SpawnedRifleman = (_sideCivGroup createUnit [sRiflemanFriendInsurg, _wayPosInit, [], 10, "NONE"]);
			_SpawnedRifleman = (_sideCivGroup createUnit [sRiflemanFriendInsurg, _wayPosInit, [], 10, "NONE"]);
			[_SpawnedRifleman] joinSilent (_sideCivGroup);
			if (!_bRebelLeaderPicked) then {
				_SpawnedRifleman addaction [localize "STR_TRGM2_trendFunctions_TalkToLeader",{[_this select 0, _this select 1] spawn TREND_fnc_TalkRebLead}];
				_SpawnedRifleman addEventHandler ["killed", {_this spawn TREND_fnc_InsKilled;}];
				//_SpawnedRifleman forceAddUniform _sCivUniform;
				removeHeadgear _SpawnedRifleman;
				_bRebelLeaderPicked = true;
			}
			else {
				_sInitString = "this addEventHandler [""killed"", {_this spawn TREND_fnc_InsKilled;}]; removeHeadgear this;Removevest this;";
				_SpawnedRifleman addEventHandler ["killed", {_this spawn TREND_fnc_InsKilled;}];

				_SpawnedRifleman spawn TREND_fnc_badReb;

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
		_allBuildingPos2 = _randBuilding2 buildingPos -1;

		_wpSideCiv = nil;
		//_wpSideCiv = _sideCivGroup addWaypoint [_randBuilding2 buildingPos (selectRandom _allBuildingPos2), 0]; //This line has error "0 eleemnts provided, 3 expected"
		try {
			//_wpSideCiv = _sideCivGroup addWaypoint [selectRandom _allBuildingPos2, 0]; //This line has error "0 eleemnts provided, 3 expected"
			_wayPosInit = selectRandom _allBuildingPos2;
			if (!isNil "_wayPosInit") then {
				_wpSideCiv = _sideCivGroup addWaypoint [_wayPosInit, 0]; //This line has error "0 eleemnts provided, 3 expected"
			}

		}
		catch {
			hint format ["Script issue: %1",selectRandom _allBuildingPos2];
		};
		//_wp1 = _group addWaypoint [_wp1Pos, 0];

		[_sideCivGroup, _iCountWaypoints] setWaypointSpeed "LIMITED";
		[_sideCivGroup, _iCountWaypoints] setWaypointBehaviour "SAFE";
		if (_iCountWaypoints == 4) then{[_sideCivGroup, 8] setWaypointType "CYCLE";};
		_iCountWaypoints = _iCountWaypoints + 1;
	};
	_sideCivGroup setBehaviour "SAFE";

	_iCount = _iCount + 1;
};

true;
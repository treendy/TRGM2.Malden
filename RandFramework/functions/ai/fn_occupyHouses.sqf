//Puts small groups of insurgents into random buildings around a position (with a small chance of a sentry near the AO)
params ["_sidePos", "_distFromCent", "_unitCounts", "_InsurgentSide", "_bThisMissionCivsOnly"];

private _unitCount = selectRandom _unitCounts;

private _iCount = 0;

if (!_bThisMissionCivsOnly) then {
	while {_iCount <= _unitCount} do
	{
		_allBuildings = nearestObjects [_sidePos, BasicBuildings, _distFromCent];
		_randBuilding = selectRandom _allBuildings;
		_randBuildingPos = getPos _randBuilding;
		if ((_randBuilding distance getMarkerPos "mrkHQ") > BaseAreaRange && !(_randBuildingPos in OccupiedHousesPos)) then { //"mrkHQ", BaseAreaRange

			OccupiedHousesPos = OccupiedHousesPos + [_randBuildingPos];

			_thisGroup = createGroup _InsurgentSide;
			sRiflemanToUse createUnit [position _randBuilding, _thisGroup];
			if (selectRandom [true,false]) then {sRiflemanToUse createUnit [position _randBuilding, _thisGroup];};

			_teamLeaderUnit = _thisGroup createUnit [sRiflemanToUse,_randBuildingPos,[],0,"NONE"];
			[_randBuildingPos, units group _teamLeaderUnit, -1, true, false,true] spawn TRGM_fnc_Zen_OccupyHouse;


			_iCountNoOfCPs = selectRandom[0,0,0,0,1];  //number of sentries (so high chance of not being any, or one may be near an occupied building)
			if ((_sidePos distance _randBuilding) > 400) then {_iCountNoOfCPs = selectRandom[0,0,1];};
			//sentry with no animations, the base area is not excluded here
			[_sidePos, _iCountNoOfCPs, 0, 0, 50, false, east, [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse], false, true, false, UnarmedScoutVehicles, 50, false, false] call TRGM_fnc_spawnCheckpoints;
		};


		_iCount = _iCount + 1;
	};
};

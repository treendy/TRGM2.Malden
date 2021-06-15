params ["_sidePos", "_distFromCent", "_unitCounts", "_InsurgentSide", "_bThisMissionCivsOnly"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

_unitCount = selectRandom _unitCounts;

_iCount = 0; //_unitCount
_allBuildings = nil;
_sAreaMarkerName = nil;
_randBuilding = nil;

if (!_bThisMissionCivsOnly) then {
    while {_iCount <= _unitCount} do
    {
        _allBuildings = nearestObjects [_sidePos, ["House"] + TRGM_VAR_BasicBuildings, _distFromCent];
        //_allBuildings = nearestObjects [_sidePos, ["house"], _distFromCent];
        _randBuilding = selectRandom _allBuildings;
        if (!isNil "_randBuilding") then {
            _randBuildingPos = getPos _randBuilding;
            if ((_randBuilding distance getMarkerPos "mrkHQ") > TRGM_VAR_BaseAreaRange && !(_randBuildingPos in TRGM_VAR_OccupiedHousesPos)) then { //"mrkHQ", TRGM_VAR_BaseAreaRange
            //if ((_randBuilding distance getMarkerPos "mrkHQ") > TRGM_VAR_BaseAreaRange) then { //"mrkHQ", TRGM_VAR_BaseAreaRange

                TRGM_VAR_OccupiedHousesPos = TRGM_VAR_OccupiedHousesPos + [_randBuildingPos];
                //[format["test:%1",(_randBuilding distance getMarkerPos "mrkHQ")]] call TRGM_GLOBAL_fnc_notify;
                //sleep 1;

                _thisGroup = nil;
                _thisGroup = createGroup _InsurgentSide;
                _thisGroup createUnit [(call sRiflemanToUse), position _randBuilding, [], 0, "NONE"];
                if (random 1 < .50) then {_thisGroup createUnit [(call sRiflemanToUse), position _randBuilding, [], 0, "NONE"];};
                //HERE!!!! copy and paste the zen init script into a placed unig, then run and see if he is in building!!! (esc out of TRGM dialog)
                //(call sRiflemanToUse) createUnit [position _randBuilding, _thisGroup, "[getPosATL this, units group this, 10, false, false] spawn TRGM_SERVER_fnc_zenOccupyHouse;"];

                _teamLeaderUnit = _thisGroup createUnit [(call sTeamleaderToUse),_randBuildingPos,[],0,"NONE"];
                [_randBuildingPos, units group _teamLeaderUnit, -1, true, false,true] spawn TRGM_SERVER_fnc_zenOccupyHouse;

                _iCountNoOfCPs = selectRandom[0,0,0,0,1];  //number of checkpoints (so high chance of not being any, or one may be near an occupied building)
                if ((_sidePos distance _randBuilding) > 400) then {_iCountNoOfCPs = selectRandom[0,0,1];};
                //spawn inner random sentrys
                //if (!_bIsMainObjective) then {_iCountNoOfCPs = selectRandom [0,1];};
                if (_iCountNoOfCPs > 0) then {_dAngleAdustPerLoop = 360 / _iCountNoOfCPs;};
                while {_iCountNoOfCPs > 0} do {
                    _thisAreaRange = 50;
                    _checkPointGuidePos = _sidePos;
                    _iCountNoOfCPs = _iCountNoOfCPs - 1;
                    _flatPos = nil;
                    _flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,TRGM_VAR_CheckPointAreas + TRGM_VAR_SentryAreas,[[0,0,0],[0,0,0]]] call TRGM_GLOBAL_fnc_findSafePos;
                    if (_flatPos select 0 > 0) then {
                        _thisPosAreaOfCheckpoint = _flatPos;
                        _thisRoadOnly = false;
                        _thisSide = east;
                        _thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
                        _thisAllowBarakade = false;
                        _thisIsDirectionAwayFromAO = true;
                        [_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,(call UnarmedScoutVehicles),50,false] spawn TRGM_SERVER_fnc_setCheckpoint;
                    }
                };
            };
        };
        _iCount = _iCount + 1;
    };
};


true;
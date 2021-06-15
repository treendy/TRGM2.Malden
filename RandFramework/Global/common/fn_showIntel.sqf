params ["_AllowedIntelToShow", "_FoundViaType"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if (side player isEqualTo west) then {
    _IntelToShow = 0;
    _iAttemptCount = 0;
    while {_IntelToShow isEqualTo 0 && _iAttemptCount < 100} do {
        _iAttemptCount = _iAttemptCount + 1;
        _IntelToShow = selectRandom _AllowedIntelToShow;
        if (_IntelToShow in TRGM_VAR_IntelFound) then {_IntelToShow = 0};
    };


    TRGM_VAR_TempIntelShowPos =  ""; publicVariable "TRGM_VAR_TempIntelShowPos";


    if (_FoundViaType isEqualTo "CommsTower") then {
        [(localize "STR_TRGM2_PickingUpComms")] call TRGM_GLOBAL_fnc_notify;
        sleep 4;
    };



    if (_IntelToShow isEqualTo 0) then { //Nothing found
        [(localize "STR_TRGM2_showIntel_NoIntel")] call TRGM_GLOBAL_fnc_notify;
    }
    else {
        TRGM_VAR_IntelFound pushBack _IntelToShow;
        publicVariable "TRGM_VAR_IntelFound";
    };

    if (_IntelToShow isEqualTo 1) then { //Mortor team location
        [[], {
            TRGM_VAR_TempIntelShowPos = nearestObjects [TRGM_VAR_ObjectivePossitions select 0,(call sMortar) + (call sMortarMilitia),3000];
            publicVariable "TRGM_VAR_TempIntelShowPos";
        }] remoteExec ["call", 2];
        waitUntil {sleep 2; typeName TRGM_VAR_TempIntelShowPos isEqualTo "ARRAY"};
        _iCount = count TRGM_VAR_TempIntelShowPos;
        if (_iCount > 0) then {
            {
                _test = nil;
                _test = createMarker [format["MrkIntelMortor%1",_forEachIndex], getPos _x];
                _test setMarkerShape "ICON";
                _test setMarkerType "o_art";
                _test setMarkerText "Mortar";
            } forEach TRGM_VAR_TempIntelShowPos;
            [(localize "STR_TRGM2_showIntel_MortarMapUpdated")] call TRGM_GLOBAL_fnc_notify;
        }
        else {
            [(localize "STR_TRGM2_showIntel_MortarMapNoUpdate")] call TRGM_GLOBAL_fnc_notify;
        };
    };
    if (_IntelToShow isEqualTo 2) then { //AAA team location
        [[], {
            TRGM_VAR_TempIntelShowPos = nearestObjects [TRGM_VAR_ObjectivePossitions select 0,[(call sAAAVeh)] + [(call sAAAVehMilitia)] + (call DestroyAAAVeh),3000];
            publicVariable "TRGM_VAR_TempIntelShowPos";
        }] remoteExec ["call", 2];
        waitUntil {sleep 2; typeName TRGM_VAR_TempIntelShowPos isEqualTo "ARRAY"};
        _iCount = count TRGM_VAR_TempIntelShowPos;
        _iStep = 0;
        if (_iCount > 0) then {
            {
                _test = nil;
                _test = createMarker [format["MrkIntelAAA%1",_forEachIndex], getPos _x];
                _test setMarkerShape "ICON";
                _test setMarkerType "o_art";
                _test setMarkerText (localize "STR_TRGM2_showIntel_AAAMarker");
                _iStep = _iStep + 1;
            } forEach TRGM_VAR_TempIntelShowPos;
            [(localize "STR_TRGM2_showIntel_AAAMapUpdated")] call TRGM_GLOBAL_fnc_notify;
        }
        else {
            [(localize "STR_TRGM2_showIntel_AAAMapNoUpdate")] call TRGM_GLOBAL_fnc_notify;
        };
    };
    if (_IntelToShow isEqualTo 3) then { //Comms tower location
        if (TRGM_VAR_bHasCommsTower) then {
            _test = nil;
            _test = createMarker ["CommsIntelAAA1", TRGM_VAR_CommsTowerPos];
            _test setMarkerShape "ICON";
            _test setMarkerType "mil_destroy";
            _test setMarkerText (localize "STR_TRGM2_showIntel_CommsTowerMarker");
          [(localize "STR_TRGM2_showIntel_CommsTowerMapUpdated")] call TRGM_GLOBAL_fnc_notify;
        }
        else {
            [(localize "STR_TRGM2_showIntel_CommsTowerMapNoUpdate")] call TRGM_GLOBAL_fnc_notify;
        };
    };
    if (_IntelToShow isEqualTo 4) then { //All checkpoints
        _bFoundcheckpoints = false;
        {
            _distanceToCheckPoint = (_x select 0) distance (TRGM_VAR_ObjectivePossitions select 0);
            _checkpointPos = _x select 0;
            if (_distanceToCheckPoint < 1000) then {
                _bFoundcheckpoints = true;
                _test = nil;
                _test = createMarker [format["MrkIntelCheckpoint%1%2",_checkpointPos select 0, _checkpointPos select 1], _checkpointPos];
                _test setMarkerShape "ICON";
                _test setMarkerType "o_inf";
                _test setMarkerText (localize "STR_TRGM2_setCheckpoint_MarkerText");
            };
        } forEach TRGM_VAR_CheckPointAreas;
        if (_bFoundcheckpoints) then {
            [(localize "STR_TRGM2_showIntel_CheckpointMapUpdated")] call TRGM_GLOBAL_fnc_notify;
        }
        else {
            [(localize "STR_TRGM2_showIntel_CheckpointMapNoUpdate")] call TRGM_GLOBAL_fnc_notify;
        };

    };
    if (_IntelToShow isEqualTo 5) then { //AT Mine field
        if (count TRGM_VAR_ATFieldPos isEqualTo 0) then {
            [(localize "STR_TRGM2_showIntel_NoATArea")] call TRGM_GLOBAL_fnc_notify;
        }
        else {
            {
                _test = nil;
                _test = createMarker [format["ATIntel%1%2",_x select 0,_x select 1], _x];
                _test setMarkerShape "ICON";
                _test setMarkerType "mil_warning";
                _test setMarkerText (localize "STR_TRGM2_showIntel_ATAreaMarker");
                [(localize "STR_TRGM2_showIntel_ATArea")] call TRGM_GLOBAL_fnc_notify;
            } forEach TRGM_VAR_ATFieldPos;
        };
    };
};


true;
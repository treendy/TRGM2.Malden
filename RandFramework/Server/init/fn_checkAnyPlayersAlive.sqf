format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

sleep 3;
_bEnded = false;
while {!_bEnded} do {
    _bAnyAlive = false;
    {
        if (isPlayer _x) then {
            _iRespawnTicketsLeft = [_x,nil,true] call BIS_fnc_respawnTickets;
            if (alive _x || _iRespawnTicketsLeft > 0) then {
                _bAnyAlive = true;
            };
        }
        else {
            if (alive _x) then {
                _bAnyAlive = true;
            };
        };
    } forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
    if (!_bAnyAlive) then {
        ["end3", true, 5] remoteExec ["BIS_fnc_endMission"];
        _bEnded = true;
        sleep 5;
    };
    sleep 3;
};
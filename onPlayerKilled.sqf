"OnPlayerKilled.sqf" call TRGM_GLOBAL_fnc_log;
params ["_oldUnit", "_killer", "_respawn", "_respawnDelay"];
TRGM_VAR_debugMessages = TRGM_VAR_debugMessages + "Player Killed";
TRGM_VAR_debugMessages = TRGM_VAR_debugMessages + format["KILLED: %1", name player];
TRGM_VAR_debugMessages = TRGM_VAR_debugMessages + format["KILLED Distance: %1", player distance getMarkerPos "MrkHQ"];

if (TRGM_VAR_bDebugMode) then {[format["KILLED!: %1", player distance getMarkerPos "MrkHQ"]] call TRGM_GLOBAL_fnc_notify; sleep 3;};

if (player distance getMarkerPos "MrkHQ" > TRGM_VAR_SaveZoneRadius) then {
    waitUntil {!(TRGM_Logic getVariable "DeathRunning")};
    TRGM_Logic setVariable ["DeathRunning", true, true];

    _aceSource = player getVariable ["ace_medical_lastDamageSource", objNull];
    if (!(_aceSource isEqualTo objNull)) then {
        _killer = _aceSource;
    };

    TRGM_VAR_debugMessages = TRGM_VAR_debugMessages + format["KILLED OUTSIDE SAFEZONE, SIDE: %1 - VEHICLE: %2 - PlayerObject: %3", side _killer,vehicle player, player];
    if (_killer != player) then {
        TRGM_VAR_debugMessages = TRGM_VAR_debugMessages + format["KILLER IS NOT THE PLAYER, Killer: %1 - %2", _killer, name _killer];
        TRGM_VAR_KilledPlayers pushBack getPlayerUID player;
        TRGM_VAR_KilledPositions pushBack [getPlayerUID player,getPos Player];
        publicVariable "TRGM_VAR_KilledPlayers";
        publicVariable "TRGM_VAR_KilledPositions";

        _iPointsToAdd = 0.2;
        if (TRGM_VAR_iMissionParamType != 5) then { //if not campaign, then work out how many rep points team gain when a player is killed
            _justPlayers = allPlayers - entities "HeadlessClient_F";
            _iPlayerCount = count _justPlayers;
            _iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);
            _iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;
        };

        [_iPointsToAdd,format[localize "STR_TRGM2_TRGMOnPlayerKilled_Killed", name player]] spawn TRGM_GLOBAL_fnc_adjustBadPoints;
        //[_iPointsToAdd,format["Player was killed", name player]] spawn TRGM_GLOBAL_fnc_adjustBadPoints;
        //TRGM_VAR_BadPoints = TRGM_VAR_BadPoints + 0.2; publicVariable "TRGM_VAR_BadPoints"

        _tombStone = selectRandom TRGM_VAR_TombStones createVehicle TRGM_VAR_GraveYardPos;
        _tombStone setDir TRGM_VAR_GraveYardDirection;
        _tombStone setVariable ["Message", format[localize "STR_TRGM2_RecruiteInf_KIA",name player],true];
        //_tombStone addAction ["Read",{[format["%1",(_this select 0) getVariable "Message"]] call TRGM_GLOBAL_fnc_notify}];
        [_tombStone, [localize "STR_TRGM2_RecruiteInf_Read","[format['%1',(_this select 0) getVariable 'Message']] call TRGM_GLOBAL_fnc_notify"]] remoteExec ["addAction", 0, true];
        //[0.2, format["KIA: %1",name (_this select 0)]] spawn TRGM_GLOBAL_fnc_adjustBadPoints;
    };

    TRGM_Logic setVariable ["DeathRunning", false, true];
};


publicVariable "TRGM_VAR_debugMessages";

true;
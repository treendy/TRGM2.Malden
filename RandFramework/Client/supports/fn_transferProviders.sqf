format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
if !(call TRGM_GLOBAL_fnc_isCbaLoaded) then {
    [[chopper1]] call TRGM_GLOBAL_fnc_addTransportActions;
};

_oldUnit = _this select 0;
_oldProviders = _oldUnit getVariable ["BIS_SUPP_allProviderModules",[]];
_HQ = _oldUnit getVariable ["BIS_SUPP_HQ",nil];

if (isNil "_HQ") then {_HQ = HQMan;};

if (isNil {player getVariable ["BIS_SUPP_HQ",nil]}) then {
    if ((count _oldProviders) > 0) then {
        {
            _providerModule = _x;
            {
                if (typeOf _x isEqualTo "SupportRequester" && _oldUnit in (synchronizedObjects _x)) then {
                    [player, _x, _providerModule] call BIS_fnc_addSupportLink;
                };
            }forEach synchronizedObjects _providerModule;
        }forEach _oldProviders;
    };

    player setVariable ["BIS_SUPP_transmitting", false];
    player kbAddTopic ["BIS_SUPP_protocol", "A3\Modules_F\supports\kb\protocol.bikb", "A3\Modules_F\supports\kb\protocol.fsm", {call compile preprocessFileLineNumbers "A3\Modules_F\supports\kb\protocol.sqf"}];
    player setVariable ["BIS_SUPP_HQ", _HQ];
};

{
    _used = _oldUnit getVariable [format ["BIS_SUPP_used_%1",_x], 0];
    player setVariable [format ["BIS_SUPP_used_%1", _x], _used, true]
} forEach [
    "Artillery",
    "CAS_Heli",
    "CAS_Bombing",
    "UAV",
    "Drop",
    "Transport"
];
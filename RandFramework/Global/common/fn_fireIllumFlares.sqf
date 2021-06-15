_player = _this select 0;
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

titleText[localize "STR_TRGM2_select_flare_location", "PLAIN"];
openMap true;
onMapSingleClick "FlarePos = _pos; openMap false; onMapSingleClick '';true;";
sleep 1;
waitUntil {sleep 2; !visibleMap};

//sleep 60;
_countSec = 300; //300 = 5 mins

_pos = FlarePos;
while {_countSec > 0} do {
    _xPos = (_pos select 0)-200;
    _yPos = (_pos select 1)-200;

    _randomPos = [_xPos+(random 400),_yPos+(random 400),0];
    [_randomPos] spawn TRGM_GLOBAL_fnc_fireAOFlares;
    delaySec = selectRandom[2,3,4,5];
    _countSec = _countSec - delaySec;
    sleep delaySec;

    _randomPos = [_xPos+(random 400),_yPos+(random 400),0];
    [_randomPos] spawn TRGM_GLOBAL_fnc_fireAOFlares;
    delaySec = selectRandom[2,3,4,5];
    _countSec = _countSec - delaySec;
    sleep delaySec;

    _randomPos = [_xPos+(random 400),_yPos+(random 400),0];
    [_randomPos] spawn TRGM_GLOBAL_fnc_fireAOFlares;
    delaySec = selectRandom[20,25];
    _countSec = _countSec - delaySec;
    sleep delaySec;
};

true;
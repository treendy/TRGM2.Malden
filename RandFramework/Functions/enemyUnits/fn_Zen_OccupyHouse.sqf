// infantry Occupy House
// by Zenophon
// Released under Creative Commons Attribution-NonCommercial 4.0 international (CC BY-NC 4.0)
// http://creativecommons.org/licenses/by-nc/4.0/

// Teleports the units to random windows of the building(s) within the distance
// faces units in the right direction and orders them to stand up or crouch on a roof
// units will only fill the building to as many positions as there are windows
// Multiple buildings can be filled either evenly or to the limit of each sequentially
// Usage : call, execVM
// params: 1. Array, the building(s) nearest this position is used
// 2. Array of objects, the units that will garrison the building(s)
// (opt.) 3. Scalar, radius in which to fill building(s), -1 for only nearest building, (default: -1)
// (opt.) 4. Boolean, true to put units on the roof, false for only inside, (default: false)
// (opt.) 5. Boolean, true to fill all buildings in radius evenly, false for one by one, (default: false)
// (opt.) 6. Boolean, true to fill from the top of the building down, (default: false)
// (opt.) 7. Boolean, true to order AI units to move to the position instead of teleporting, (default: false)
// Return: Array of objects, the units that were not garrisoned

#define EYE_HEIGHT 1.53
#define CHECK_DISTANCE 5
#define FOV_ANGLE 10
#define ROOF_CHECK 4
#define ROOF_EDGE 2

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

private ["_center", "_units", "_buildingradius", "_putonRoof", "_fillEvenly", "_Zen_Extendposition", "_buildingsArray", "_buildingPosArray", "_buildingpositions", "_posArray", "_unitindex", "_j", "_building", "_posArray", "_randomindex", "_housePos", "_startangle", "_i", "_checkPos", "_hitcount", "_isRoof", "_edge", "_k", "_unUsedunits", "_array", "_sortHeight", "_Zen_insertionsort", "_Zen_ArrayShuffle", "_domove"];

_center = _this param [0, [0, 0, 0], [[]], 3];
_units = _this param [1, [objNull], [[]]];
_buildingradius = _this param [2, -1, [0]];
_putonRoof = _this param [3, false, [true]];
_fillEvenly = _this param [4, false, [true]];
_sortHeight = _this param [5, false, [true]];
_domove = _this param [6, false, [true]];

if (_center isEqualto [0, 0, 0]) exitwith {
    player sideChat str "Zen_Occupy House Error : invalid position given.";
    diag_log "Zen_Occupy House Error : invalid position given.";
    ([])
};

if ((count _units isEqualTo 0) || {
    isNull (_units select 0)
}) exitwith {
    // player sideChat str "Zen_Occupy House Error : No units given.";
    diag_log "Zen_Occupy House Error : No units given.";
    ([])
};

_Zen_Extendposition = {
    private ["_center", "_dist", "_phi"];

    _center = _this select 0;
    _dist = _this select 1;
    _phi = _this select 2;

    ([(_center select 0) + (_dist * (cos _phi)), (_center select 1) + (_dist * (sin _phi)), (_this select 3)])
};

_Zen_insertionsort = {
    private ["_i", "_j", "_count", "_array", "_element", "_value", "_comparator"];

    _array = _this select 0;
    _comparator = _this select 1;
    _count = count _array - 1;

    if (count _array isEqualTo 0) exitwith {};
    for "_i" from 1 to _count step 1 do {
        scopeName "forI";
        _element = _array select _i;
        _value = (_element call _comparator);

        for [{
            _j = _i
        }, {
            _j >= 1
        }, {
            _j = _j - 1
        }] do {
        if (_value > ((_array select (_j - 1)) call _comparator)) then {
            breakto "forI";
        };
        _array set [_j, _array select (_j - 1)];
    };

    _array set [_j, _element];
};
if (true) exitwith {};
};

_Zen_ArrayShuffle = {
    private ["_array", "_j", "_i", "_temp"];
    _array = _this select 0;

    if (count _array > 1) then {
        for "_i" from 0 to (count _array - 1) do {
            _j = _i + floor random ((count _array) - _i);
            _temp = _array select _i;
            _array set [_i, (_array select _j)];
            _array set [_j, _temp];
        };
    };
    if (true) exitwith {};
};

if (_buildingradius < 0) then {
    _buildingsArray = [nearestBuilding _center];
} else {
    _buildingsArray0 = nearestobjects [_center, TREND_BasicBuildings, _buildingradius];
    _buildingsArray1 = nearestobjects [_center, ["building"], _buildingradius];
    _buildingsArray = _buildingsArray0 arrayintersect _buildingsArray1;
};

if (count _buildingsArray isEqualTo 0) exitwith {
    player sideChat str "Zen_Occupy House Error : No buildings found.";
    diag_log "Zen_Occupy House Error : No buildings found.";
    ([])
};

_buildingPosArray = [];
[_buildingsArray] call _Zen_ArrayShuffle;
{
    _posArray = [];
    for "_i" from 0 to 1000 do {
        if ((_x buildingPos _i) isEqualto [0, 0, 0]) exitwith {};
        _posArray pushBack (_x buildingPos _i);
    };

    _buildingPosArray pushBack _posArray;
} forEach _buildingsArray;

if (_sortHeight) then {
    {
        [_x, {
            -1 * (_this select 2)
        }] call _Zen_insertionsort;
    } forEach _buildingPosArray;
} else {
    {
        [_x] call _Zen_ArrayShuffle;
    } forEach _buildingPosArray;
};

_unitindex = 0;
for [{
    _j = 0
}, {
    (_unitindex < count _units) && {
        (count _buildingPosArray > 0)
    }
}, {
    _j = _j + 1;
}] do {
scopeName "for";

_building = _buildingsArray select (_j mod (count _buildingsArray));
_posArray = _buildingPosArray select (_j mod (count _buildingPosArray));

if (count _posArray isEqualTo 0) then {
    _buildingsArray deleteAt (_j mod (count _buildingsArray));
    _buildingPosArray deleteAt (_j mod (count _buildingPosArray));
};

while {(count _posArray) > 0} do {
    scopeName "while";
    if (_unitindex >= count _units) exitwith {};

    _housePos = _posArray select 0;
    _posArray deleteAt 0;
    _housePos = [(_housePos select 0), (_housePos select 1), (_housePos select 2) + (getTerrainHeightASL _housePos) + EYE_HEIGHT];

    _startangle = (round random 10) * (round random 36);
    for "_i" from _startangle to (_startangle + 350) step 10 do {
        _checkPos = [_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2)] call _Zen_Extendposition;
        if !(lineIntersects [_checkPos, [_checkPos select 0, _checkPos select 1, (_checkPos select 2) + 25], objNull, objNull]) then {
            if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
                _checkPos = [_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2) + (CHECK_DISTANCE * tan FOV_ANGLE)] call _Zen_Extendposition;
                if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
                    _hitcount = 0;
                    for "_k" from 30 to 360 step 30 do {
                        _checkPos = [_housePos, 20, (90 - _k), (_housePos select 2)] call _Zen_Extendposition;
                        if (lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
                            _hitcount = _hitcount + 1;
                        };

                        if (_hitcount >= ROOF_CHECK) exitwith {};
                    };

                    _isRoof = (_hitcount < ROOF_CHECK) && {
                        !(lineIntersects [_housePos, [_housePos select 0, _housePos select 1, (_housePos select 2) + 25], objNull, objNull])
                    };
                    if (!(_isRoof) || {
                        ((_isRoof) && {
                            (_putonRoof)
                        })
                    }) then {
                        if (_isRoof) then {
                            _edge = false;
                            for "_k" from 30 to 360 step 30 do {
                                _checkPos = [_housePos, ROOF_EDGE, (90 - _k), (_housePos select 2)] call _Zen_Extendposition;
                                _edge = !(lineIntersects [_checkPos, [(_checkPos select 0), (_checkPos select 1), (_checkPos select 2) - EYE_HEIGHT - 1], objNull, objNull]);

                                if (_edge) exitwith {
                                    _i = _k;
                                };
                            };
                        };

                        if (isnil "OccupiedHousesPos") then {
                            OccupiedHousesPos = []
                        };
                        _distancefromBase = getmarkerPos "mrkHQ" distance _housePos;
                        if (_distancefromBase > TREND_BaseAreaRange && !(_housePos in OccupiedHousesPos)) then {
                            OccupiedHousesPos = OccupiedHousesPos + [_housePos];
                            if (!(_isRoof) || {
                                _edge
                            }) then {
                                (_units select _unitindex) doWatch ([_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2) - (getTerrainHeightASL _housePos)] call _Zen_Extendposition);

                                (_units select _unitindex) disableAI "TARGET";
                                if (_domove) then {
                                    (_units select _unitindex) domove ASLtoATL ([(_housePos select 0), (_housePos select 1), (_housePos select 2) - EYE_HEIGHT]);
                                } else {
                                    (_units select _unitindex) setPosASL [(_housePos select 0), (_housePos select 1), (_housePos select 2) - EYE_HEIGHT];
                                    (_units select _unitindex) setDir _i;

                                    dostop (_units select _unitindex);
                                    (_units select _unitindex) forcespeed 0;
                                };

                                if (_isRoof) then {
                                    (_units select _unitindex) setunitPos "MIDDLE";
                                    (_units select _unitindex) addEventHandler ["firedNear", {
                                        [(_this select 0), ["doWN", "MIDDLE"]] spawn {
                                            if (!isServer) exitwith {};
                                            _dude = _this select 0;
                                            _stances = _this select 1;
                                            _dude removeAllEventHandlers "firedNear";
                                            while {alive _dude} do {
                                                if ((unitPos _dude) isEqualTo (_stances select 0)) then {
                                                    _dude setunitPos (_stances select 1);
                                                } else {
                                                    _dude setunitPos (_stances select 0);
                                                };
                                                sleep (1 + (random 7));
                                            };
                                        };
                                    }];
                                } else {
                                    (_units select _unitindex) setunitPos "UP";
                                    (_units select _unitindex) addEventHandler ["firedNear", {
                                        [(_this select 0), ["UP", "MIDDLE"]] spawn {
                                            if (!isServer) exitwith {};
                                            _dude = _this select 0;
                                            _stances = _this select 1;
                                            _dude removeAllEventHandlers "firedNear";
                                            while {alive _dude} do {
                                                if ((unitPos _dude) isEqualTo (_stances select 0)) then {
                                                    _dude setunitPos (_stances select 1);
                                                } else {
                                                    _dude setunitPos (_stances select 0);
                                                };
                                                sleep (1 + (random 7));
                                            };
                                        };
                                    }];
                                };

                                _unitindex = _unitindex + 1;
                                if (_fillEvenly) then {
                                    breakto "for";
                                } else {
                                    breakto "while";
                                };
                            };
                        };
                    };
                };
            };
        };
    };
};
};

if (_domove) then {
    [_units, _unitindex] spawn {
        _units = _this select 0;
        _unitindex = _this select 1;

        _usedunits = [];
        for "_i" from 0 to (_unitindex - 1) do {
            _usedunits pushBack (_units select _i);
        };

        while {count _usedunits > 0} do {
            sleep 1;
            _toremove = [];
            {
                if (unitReady _x) then {
                    dostop _x;
                    _x forcespeed 0;
                    _toremove pushBack _forEachindex;
                };
            } forEach _usedunits;

            {
                _usedunits deleteAt (_x - _forEachindex);
            } forEach _toremove;
        };
        if (true) exitwith {};
    };
};

_unUsedunits = [];
for "_i" from _unitindex to (count _units - 1) step 1 do {
    _unUsedunits pushBack (_units select _i);
};

(_unUsedunits)

// Changelog
// 7/21/15
// 1. Added: Error reporting for invalid position and unit array arguments
// 1. Added: Check and error report if no buildings are found
// 3. Improved: parameters 3, 4, and 5 are now optional and check for the correct type
// 4. Improved: parameters 6 and 7 check for the correct type
// 5. Improved: AI should now stay in place better (thanks to JohnnyBoy)

// 7/6/15
// 1. Added: AI now take cover when fired upon (credit to JohnnyBoy)
// 2. Added: parameter to order the AI to move to their position
// 3. Improved: The order of buildings filled is now random
// 4. Improved: A few minor optimizations

// 6/30/15
// 1. Added: parameter to fill buildings from top to bottom
// 2. Improved: Optimized

// 7/31/14
// 1. Added: parameter to cycle through each building in the radius, giving units to each one
// 2. Improved: units on roof are only placed at the edge, and face the edge
// 3. Improved: Optimized roof check
// 4. Improved: General script cleanup

// 7/28/14
// 1. Fixed: units facing the wrong window
// 2. Added: parameter for distance to select multiple buildings
// 3. Added: parameter for units being on a roof
// 4. Improved: Now checks that unit has a good FOV from the windows
// 5. Improved: units can no longer face a windows greater than 5 meters away
// 6. Improved: units on a roof now crouch
// 7. Tweaked: Height of human eye to the exact value in ArmA

// 7/24/14
// initial Release

// Known Issues
// None
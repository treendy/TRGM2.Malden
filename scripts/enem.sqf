_thisEnem = _this; // select 0;

_bFired1 = false;
_bActivated1 = false;
_pissedcivsound = selectRandom ["allah","allah1","allah2","allah3","allah4","allah5"];
_giveupsound = selectRandom ["angryciv2"];
_civAction = selectRandom ["Acts_JetsMarshallingStop_loop","Acts_CivilInjuredChest_1"];
_happycivsound = selectRandom ["chat","chat2","chat3","chat4","chat5","chat6","chat7","chat8"];




while {alive _thisEnem && !_bFired1} do {
    _nearestunits = nearestObjects [getPos _thisEnem,["Man"],105];


    {
        if (side _x == west) then {
                if (!_bActivated1) then {
                    _bActivated1 = true;

                if (selectRandom[true,false]) then {

waitUntil { sleep 3; (_this distance _x) < 20 };
if ((_thisEnem KnowsAbout _x) < 0.1) exitwith {_bFired = true;[[], 'scripts\Enemintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];[_thisEnem,_happycivsound] remoteExecCall ["say3D", 0];};
                    [_thisEnem,_pissedcivsound] remoteExecCall ["say3D", 0];
                    _bFired = true;
}
 else
{
                if (selectRandom[true,false]) then {

waitUntil { sleep 3; (_this distance _x) < 45 };
if ((_thisEnem KnowsAbout _x) < 0.1) exitwith {_bFired = true;};
                    [_thisEnem,_pissedcivsound] remoteExecCall ["say3D", 0];
                    _bFired = true;
}
 else
{
                if (selectRandom[false,true,false]) then {

waitUntil { sleep 3; (_this distance _x) < 25 };
if ((_thisEnem KnowsAbout _x) < 0.1) exitwith {_bFired = true;};
                    [_thisEnem,_pissedcivsound] remoteExecCall ["say3D", 0];
                    _bFired = true;
}
 else
{
                if (selectRandom[true]) then {
waitUntil { sleep 3; (_this distance _x) < 20 };
_thisEnem execVM "scripts\mortar.sqf";
if ((_thisEnem KnowsAbout _x) < 0.1) exitwith {[[], 'scripts\Enemintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];[_thisEnem,_happycivsound] remoteExecCall ["say3D", 0];_bFired = true;};
                    [_thisEnem,_giveupsound] remoteExecCall ["say3D", 0];
                   _thisEnem disableAi "anim";
                   _thisEnem switchmove _civAction;
                   _thisEnem setcaptive true;
                    _bFired = true;

               };
             }; 
           };
         };
       };
      };
    } forEach _nearestunits;
    sleep 5;
};



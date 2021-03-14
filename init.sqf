"Init.sqf" call TREND_fnc_log;

call TREND_fnc_initGlobalVars;

waitUntil { TREND_playerIsChoosingHQpos || TREND_NeededObjectsAvailable; };

if (isServer && !TREND_NeededObjectsAvailable) then {
	waitUntil {TREND_HQPosFound};
	_handle = [TREND_foundHQPos] spawn TREND_fnc_createNeededObjects;
   waitUntil {scriptDone _handle};

   { [[_x], {(_this select 0) allowDamage false}] remoteExec ["call", _x]; } forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});

   waitUntil { sleep 10; TREND_NeededObjectsAvailable; };

   {
      if (!isPlayer _x) then {
         _safePos = [TREND_foundHQPos, 0,25,15,0,0.15,0,[],[[TREND_foundHQPos select 0, TREND_foundHQPos select 1],[TREND_foundHQPos select 0, TREND_foundHQPos select 1]]] call TREND_fnc_findSafePos;
         [[_x, _safePos], {
            (_this select 0) setpos (_this select 1);
            (_this select 0) setdamage 0;
            (_this select 0) allowDamage true;
         }] remoteExec ["call", _x];
      } else {
            [[_x], {
               (_this select 0) setpos [(TREND_foundHQPos select 0) - 10, (TREND_foundHQPos select 1)];
               (_this select 0) setdamage 0;
               (_this select 0) allowDamage true;
               titleCut ["", "BLACK IN", 5];
            }] remoteExec ["call", _x];
      };
   } forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
};

if (isServer) then {
	TREND_FirstSpottedHasHappend = false; publicVariable "TREND_FirstSpottedHasHappend";
};

tf_give_personal_radio_to_regular_soldier = true; publicVariable "tf_give_personal_radio_to_regular_soldier";
tf_no_auto_long_range_radio = true; publicVariable "tf_no_auto_long_range_radio";


_handle = call FHQ_fnc_ttiInit;
waitUntil { _handle; };
_handle = call FHQ_fnc_ttiPostInit;
waitUntil { _handle; };

[
   west,
      [(localize "STR_TRGM2_Init_Mission"), ""],
      ["", ""],
   east,
      ["", ""],
      ["", ""],
   {true},
      [(localize "STR_TRGM2_Init_TRGM2Engine"), (localize "STR_TRGM2_Init_Credits"), "Treendy, Refactored by TheAce0296"],
      [(localize "STR_TRGM2_Init_TRGM2Engine"), (localize "STR_TRGM2_Init_ScriptsUsed"), localize "STR_TRGM2_TRGMSetUnitGlobalVars_ScriptsUsed"]
] call FHQ_fnc_ttAddBriefing;

"Marker1" setMarkerTextLocal (localize "STR_TRGM2_Init_MarkerText_HQ"); //Head Quarters marker localize
"transportChopper" setMarkerTextLocal (localize "STR_TRGM2_Init_MarkerText_TransportChopper"); //Transport Chopper marker localize

[laptop1, ["Request Units/Vehicles", {player call TREND_fnc_openDialogRequests;}, [], 0, true, true, "", "_this isEqualTo player"]] remoteExec ["addAction", 0, true];

[] spawn TREND_fnc_mainInit;

true;
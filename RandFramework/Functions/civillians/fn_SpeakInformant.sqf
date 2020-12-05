params ["_thisCiv", "_caller", "_args"];
_args params ["_iSelected", "_bCreateTask"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (side _caller == west) then {

	//TREND_ClearedPositions pushBack (TREND_ObjectivePossitions select _iSelected);
	TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, _caller] call BIS_fnc_nearestPosition);
	publicVariable "TREND_ClearedPositions";
	//removeAllActions _thisCiv;
	[_thisCiv] remoteExec ["removeAllActions", 0, true];


	if (_bCreateTask) then {
		if (alive _thisCiv) then {
			sName = format["InfSide%1",_iSelected];
			[sName, "succeeded"] remoteExec ["FHQ_fnc_ttsetTaskState", 0];
		}
		else {
			hint "He is dead you muppet!";
			sName = format["InfSide%1",_iSelected];
			[sName, "failed"] remoteExec ["FHQ_fnc_ttsetTaskState", 0];
		};
	}
	else {

		_ballowSearch = true;

		hint "You start to talk to the informant...";
		if (alive _thisCiv) then {
			//increased chance of results
			_searchChance = [true,false];
		}
		else {
			//normal search
			_searchChance = [true,false,false,false,false];
		};


		_thisCiv disableAI "move";
		sleep 3;
		_thisCiv enableAI "move";
		if (alive _thisCiv) then {
			//normal search
			_ballowSearch = true;

		}
		else {
			hint "He is dead you muppet!";
			_ballowSearch = false;
		};

		if (_ballowSearch) then {
			if (getMarkerType format["mrkMainObjective%1",0] == "empty") then {
				format["mrkMainObjective%1",0] setMarkerType "mil_unknown"; //NOTE: hard coded zero as only one main task will exict (currently!)
				hint "Map updated with main AO Location";
			}
			else {
				[TREND_IntelShownType,"SpeakInform"] spawn TREND_fnc_showIntel;
				sleep 5;
				[TREND_IntelShownType,"SpeakInform"] spawn TREND_fnc_showIntel;
			};

		};

	};
};
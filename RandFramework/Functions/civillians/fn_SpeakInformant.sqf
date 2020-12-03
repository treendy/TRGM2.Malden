
_thisCiv = _this select 0;
_thisPlayer = _this select 1;
_params = _this select 3;

_iSelected = _params select 0;
_bCreateTask = _params select 1;

if (side player == west) then {

	//TREND_ClearedPositions pushBack (TREND_ObjectivePossitions select _iSelected);
	TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, player] call BIS_fnc_nearestPosition);
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
params ["_thisCiv","_thisPlayer","_id","_params"];
_params params ["_iSelected","_bCreateTask"];

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
			_thisCiv switchMove "Acts_ExecutionVictim_Loop";
			//_thisCiv disableAI "anim";
		}
		else {
			//fail task
			hint "He is dead you muppet!";
			//TREND_badPoints = TREND_badPoints + 10;
			//publicVariable "TREND_badPoints";
			//[format["InfSide%1",_iSelected], "failed"] call FHQ_fnc_ttsetTaskState;
			sName = format["InfSide%1",_iSelected];
			[sName, "failed"] remoteExec ["FHQ_fnc_ttsetTaskState", 0];
		};
	}
	else {
		_searchChance = [true,false,false,false];

		hint "Map updated with intel found";


		if (alive _thisCiv) then {
			//increased chance of results
			_searchChance = [true,false];
		}
		else {
			//normal search
			_searchChance = [true,false,false,false,false];
		};

		removeAllActions _thisCiv;

		if (getMarkerType format["mrkMainObjective%1",0] == "empty") then {
			format["mrkMainObjective%1",0] setMarkerType "mil_unknown"; //NOTE: hard coded zero as only one main task will exict (currently!)
			hint "Map updated with main AO location";
		}
		else {

			if (alive _thisCiv) then {
				[TREND_IntelShownType,"IntOfficer"] spawn TREND_fnc_showIntel;
				sleep 2;
				[TREND_IntelShownType,"IntOfficer"] spawn TREND_fnc_showIntel;
			}
			else {
				hint (localize "STR_TRGM2_interrogateOfficer_DeadGuy")
			};
		};
	};


};


_thisCiv = _this select 0;
_thisPlayer = _this select 1;
_params = _this select 3;

_iSelected = _params select 0;
_bCreateTask = _params select 1;

//removeAllActions _thisCiv;
[_thisCiv] remoteExec ["removeAllActions", 0, true];



if (_bCreateTask) then {
	if (alive _thisCiv) then {
		sName = format["InfSide%1",_iSelected];
		[sName, "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0];	
		_thisCiv switchMove "Acts_ExecutionVictim_Loop"; 
		//_thisCiv disableAI "anim";
	}
	else {
		//fail task
		hint "He is dead you muppet!";
		//badPoints = badPoints + 10;
		//publicVariable "badPoints";
		//[format["InfSide%1",_iSelected], "failed"] call FHQ_TT_setTaskState;
		sName = format["InfSide%1",_iSelected];
		[sName, "failed"] remoteExec ["FHQ_TT_setTaskState", 0];	
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
			hint "Map updated with intel found";
		}
		else {
			if (alive _thisCiv) then {
				[selectRandom IntelShownType,"HackData"] execVM "RandFramework\showIntel.sqf";
				[selectRandom IntelShownType,"HackData"] execVM "RandFramework\showIntel.sqf";
				[selectRandom IntelShownType,"HackData"] execVM "RandFramework\showIntel.sqf";
			}
			else {
				hint "he is dead you muppet!!!"
			};
		};
};

	
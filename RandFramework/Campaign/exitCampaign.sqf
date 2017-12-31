if (bAllAtBase) then {

	if (SaveType != 0) then {
		[SaveType,false] execVM "RandFramework\Campaign\ServerSave.sqf";
	};

	["end4", true, 7] remoteExec ["BIS_fnc_endMission"]

};

bAttemptedEnd = false; publicVariable "bAttemptedEnd"; 
if (isMultiplayer) then {
	if (isServer) then {
		{
			[_x,["Call for Extraction","RandFramework\CallExtract.sqf"]] remoteExec ["addAction",_x,true];
		} forEach playableUnits;
	};
} else {
 player addAction ["Call for Extraction","RandFramework\CallExtract.sqf"]
};
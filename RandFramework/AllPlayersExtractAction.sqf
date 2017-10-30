if (isMultiplayer) then {

	if (isServer) then {
		{
			//_x addAction ["Call for Extraction", "RandFramework\CallExtract.sqf"];
			[[_x , ["Call for Extraction","RandFramework\CallExtract.sqf"]],"addAction",true,true] call BIS_fnc_MP;
			//[[player , [""Call for Extraction"",""RandFramework\CallExtract.sqf""]],""addAction"",true,true] call BIS_fnc_MP;
		} forEach playableUnits;
	};
}
else {
 player addAction ["Call for Extraction","RandFramework\CallExtract.sqf"]
};
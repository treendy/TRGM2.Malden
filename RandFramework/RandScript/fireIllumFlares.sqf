_player = _this select 0;

titleText[localize "STR_TRGM2_select_flare_location", "PLAIN"];
openMap true;
onMapSingleClick "FlarePos = _pos; openMap false; onMapSingleClick '';true;";
sleep 1;
waitUntil {!visibleMap};

//sleep 60;
_countSec = 300; //300 = 5 mins

_pos = FlarePos;
while {_countSec > 0} do {	
	_xPos = (_pos select 0)-200;
	_yPos = (_pos select 1)-200;

	_randomPos = [_xPos+(random 400),_yPos+(random 400),0];
	[_randomPos] execVM "RandFramework\RandScript\fireAOFlares.sqf";
	//[[_randomPos],"RandFramework\RandScript\fireAOFlares.sqf"] remoteExec ["BIS_fnc_execVM"];
	delaySec = selectRandom[2,3,4,5];
	_countSec = _countSec - delaySec;
	sleep delaySec;

	_randomPos = [_xPos+(random 400),_yPos+(random 400),0];
	[_randomPos] execVM "RandFramework\RandScript\fireAOFlares.sqf";
	//[[_randomPos],"RandFramework\RandScript\fireAOFlares.sqf"] remoteExec ["BIS_fnc_execVM"];
	delaySec = selectRandom[2,3,4,5];
	_countSec = _countSec - delaySec;
	sleep delaySec;

	_randomPos = [_xPos+(random 400),_yPos+(random 400),0];
	[_randomPos] execVM "RandFramework\RandScript\fireAOFlares.sqf";
	//[[_randomPos],"RandFramework\RandScript\fireAOFlares.sqf"] remoteExec ["BIS_fnc_execVM"];
	delaySec = selectRandom[20,25];
	_countSec = _countSec - delaySec;
	sleep delaySec;
};

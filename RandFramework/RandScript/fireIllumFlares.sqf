_player = _this select 0;

titleText[localize "STR_TRGM2_select_flare_location", "PLAIN"];
openMap true;
onMapSingleClick "FlarePos = _pos; openMap false; onMapSingleClick '';true;";
sleep 1;
waitUntil {!visibleMap};

_countSec = 300; //300 = 5 mins

_pos = FlarePos;
_xPos = (_pos select 0)-200;
_yPos = (_pos select 1)-200;
while {_countSec > 0} do {
	//three flares per cycle, a short delay after the first two and a long one after the third
	{
		_randomPos = [_xPos+(random 400),_yPos+(random 400),0];
		[_randomPos] spawn TRGM_fnc_fireAOFlares;
		_delaySec = selectRandom _x;
		_countSec = _countSec - _delaySec;
		sleep _delaySec;
	} forEach [[2,3,4,5],[2,3,4,5],[20,25]];
};

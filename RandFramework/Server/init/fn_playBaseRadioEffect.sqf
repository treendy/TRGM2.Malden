format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

while {true} do {
	playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom TRGM_VAR_FriendlyRadioSounds + ".wss",baseRadio,false,getPosASL baseRadio,0.5,1,0];
	sleep selectRandom [20,30,40];
};
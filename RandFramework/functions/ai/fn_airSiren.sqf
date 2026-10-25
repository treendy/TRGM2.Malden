//Plays the air raid siren at a position 5 times, 40 seconds apart (scheduled, global sound)
params ["_pos"];

//mission folder path: description.ext path minus "description.ext" (15 chars), worked out once instead of every loop
private _missionConfigPath = str missionConfigFile;
private _sirenPath = (_missionConfigPath select [0, count _missionConfigPath - 15]) + "RandFramework\Sounds\Siren.ogg";
for "_i" from 1 to 5 do {
	playSound3D [_sirenPath, nil, false, _pos, 1.5, 1, 0];
	sleep 40;
};

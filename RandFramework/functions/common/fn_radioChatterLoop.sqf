//plays random enemy radio chatter from an object until it is destroyed (spawn on the server, playSound3D is global)
params ["_radio"];
while {!isNull _radio && {alive _radio}} do {
	playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom EnemyRadioSounds + ".wss",_radio,false,getPosASL _radio,0.5,1,0];
	sleep selectRandom [10,15,20,30];
};

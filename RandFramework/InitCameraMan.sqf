
0 enableChannel false;
1 enableChannel false;
2 enableChannel false;
3 enableChannel false;
4 enableChannel false;
5 enableChannel false;

//hint "CC";

//player removeAllActions;

player setVariable ["tf_unable_to_use_radio", true];
player setVariable ["tf_globalVolume", 0];

player addEventHandler ["GetInMan",{player action ["Eject",vehicle player];}];

[player, true] remoteExec ["hideObjectGlobal", 2];

player addaction ["tele","RandFramework\tele.sqf"];
player addaction ["Toggle Fast Run",{
	_bCurrentFastRun = player getVariable ["fastRun",false];
	player setVariable ["fastRun",!_bCurrentFastRun];
}];

[player, true] remoteExec ["hideObjectGlobal", 2];
while {(alive(player))} do
{
	//hint format["speed:%1",speed player];
	player enableFatigue false;
	player enableStamina false;
	removeAllWeapons player;
	
	if (speed player > 16) then {
		//hint "test2";
		if (player getVariable ["fastRun",false]) then {
			player setAnimSpeedCoef 6;
			player allowDamage false;
			sleep 0.4;
		};
	}
	else {
		player setAnimSpeedCoef 1;
		player allowDamage false;
		sleep 0.4;
	};
};

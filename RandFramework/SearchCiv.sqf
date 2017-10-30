
_thisCiv = _this select 0;
_thisPlayer = _this select 1;

_thisCiv disableAI "move";
hint "This civ is carrying a weapon";
//hint format ["test: %1", side _thisCiv];
sleep 3;
_thisCiv enableAI "move";
if (selectRandom[true]) then {
	_grpName = createGroup east;
	[_thisCiv] joinSilent _grpName;
	_thisCiv addMagazine "6Rnd_45ACP_Cylinder";
	_thisCiv addMagazine "6Rnd_45ACP_Cylinder";
	_thisCiv addWeapon "hgun_Pistol_heavy_02_F";
	_thisCiv dotarget _thisPlayer;
	_thisCiv commandFire _thisPlayer;
	sleep 3;
	_thisCiv fire "hgun_Pistol_heavy_02_F";
	sleep 1;
	_thisCiv fire "hgun_Pistol_heavy_02_F";
	sleep 1;
	_thisCiv fire "hgun_Pistol_heavy_02_F";

	//_thisCiv setAmmo [currentWeapon _thisCiv, 1];
	//_thisCiv forceWeaponFire [ weaponState _thisCiv select 1, weaponState _thisCiv select 2];
	//_thisCiv doFire _thisPlayer
};


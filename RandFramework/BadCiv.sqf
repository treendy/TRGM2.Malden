//if some condition is true, we give this guy a gun and change side

_thisCiv = _this; // select 0;
_bFired = false;
_bActivated = false;

while {alive _thisCiv && !_bFired} do {
	_nearestunits = nearestObjects [getPos _thisCiv,["Man"],10];
	
	{
		if ((_x in playableunits)) then {
			
			if (selectRandom[true,false,false]) then {
				if (!_bActivated) then {
					_bActivated = true;
					_grpName = createGroup east;
					[_thisCiv] joinSilent _grpName;
					_thisCiv addMagazine "6Rnd_45ACP_Cylinder";
					_thisCiv addMagazine "6Rnd_45ACP_Cylinder";
					_thisCiv addWeapon "hgun_Pistol_heavy_02_F";
					_thisCiv allowfleeing 0;
				};
				_cansee = [objNull, "VIEW"] checkVisibility [eyePos _thisCiv, eyePos _x];
				if (_cansee > 0.2) then {
					_thisCiv dotarget _x;
					_thisCiv commandFire _x;
					sleep 3;
					_thisCiv fire "hgun_Pistol_heavy_02_F";
					sleep 1;
					_thisCiv fire "hgun_Pistol_heavy_02_F";
					sleep 1;
					_thisCiv fire "hgun_Pistol_heavy_02_F";			
					_bFired = true;
				};

			};			
		};
		
	} forEach _nearestunits;
	sleep 2;
};

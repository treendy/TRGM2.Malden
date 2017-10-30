//if some condition is true, we give this guy a gun and change side

_thisCiv = _this; // select 0;
_bFired = false;

while {alive _thisCiv && !_bFired} do {
	_nearestunits = nearestObjects [getPos _thisCiv,["Man"],10];
	
	{
		if ((_x in playableunits)) then {
			if (selectRandom[true,false,false]) then {
				_grpName = createGroup east;
				[_thisCiv] joinSilent _grpName;
				
				_thisCiv dotarget _x;
				_thisCiv commandFire _x;
				_bFired = true;
			};			
		};
		
	} forEach _nearestunits;
	sleep 2;
};

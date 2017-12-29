params ["_thisCiv"];

if (!isServer) exitWith {};

/* Set Armament of this Civ 
Format:
[
	[
		*wheight*,
		[
			*gun*,
			*magazine*,
			*numberOfMags*
		]
	],
	...
]
*/
_possibleArmaments = [
	[
		1,									// weighting
		[							
			"hgun_Pistol_heavy_02_F", 	// gun
			"6Rnd_45ACP_Cylinder", 		// magazine
			2 							// amount of magazines
		]						
	],
	[
		2,
		[
			"hgun_P07_F",
			"16Rnd_9x21_Mag",
			2
		]
	],
	[
		1,
		[
			"hgun_ACPC2_F",
			"9Rnd_45ACP_Mag",
			3
		]
	]
];


_wheights = [];
{
	_wheights pushBack (_x select 0)
} forEach _possibleArmaments;

_armament = (_possibleArmaments selectRandomWeighted _wheights) select 1;
_thisCiv setVariable ["armament",_armament , true];
// to retrieve the armament use: (_civ getVariable "armament") params ["_gun","_magazine","_amount"];

[_thisCiv] spawn TRGM_fnc_badCivLoop;

[_thisCiv] remoteExec ["TRGM_fnc_badCivAddSearchAction",[0, -2] select isMultiplayer,true];
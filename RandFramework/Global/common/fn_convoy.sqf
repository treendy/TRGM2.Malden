/* Tova's Simple Comvoy Script */

params [
	"_convoyGroup",
	["_convoySpeed", 50],
    ["_convoySeparation", 50],
    ["_pushThrough", true]
];
if (_pushThrough) then {
    _convoyGroup enableAttack!(_pushThrough);
	{
        (vehicle _x) setUnloadInCombat[false, false];
    } forEach(units _convoyGroup);
};

_convoyGroup setFormation "COLUMN";

{
    (vehicle _x) limitSpeed _convoySpeed * 1.15;
    (vehicle _x) setConvoySeparation _convoySeparation;
} forEach(units _convoyGroup);

(vehicle leader _convoyGroup) limitSpeed _convoySpeed;

while { sleep 5; true } do {
    {
        if ((speed vehicle _x < 5) && (_pushThrough || (behaviour _x != "COMBAT"))) then {
            (vehicle _x) doFollow(leader _convoyGroup);
        };
    } forEach(units _convoyGroup) - (crew(vehicle(leader _convoyGroup))) - allPlayers;

	{
        (vehicle _x) setConvoySeparation _convoySeparation;
    } forEach(units _convoyGroup);
};
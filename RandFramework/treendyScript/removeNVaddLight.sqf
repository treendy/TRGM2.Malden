
{
   if ((side _x) == East) then
   {
     _x addPrimaryWeaponItem "acc_flashlight"; 
     _x enableGunLights "forceOn";
     _x unassignItem sEnemyNVClassName; 
     _x removeItem sEnemyNVClassName; 
   };
} forEach allUnits;

bAllowNoVN = true;
bForceNoNV = false;

if (selectRandom bNoVNChance) then {
{
   if ((side _x) == West) then
   {
     _x addPrimaryWeaponItem "acc_flashlight"; 
     _x enableGunLights "forceOn";
     _x unassignItem sFriendlyNVClassName; 
     _x removeItem sFriendlyNVClassName; 
   };
} forEach allUnits;

};
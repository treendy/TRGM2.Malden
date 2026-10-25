//keeps an artillery vehicle firing random rounds near the base until it is destroyed (spawn on the server)
params ["_objVehicle"];
private _Ammo = getArtilleryAmmo [_objVehicle] select 0;
while {alive _objVehicle} do {
	private _flatPos = [getMarkerPos "mrkHQ", 1000, 1200, 20, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	[_objVehicle, 1] remoteExec ["setVehicleAmmo", _objVehicle];
	[_objVehicle, [_flatPos, _Ammo, 1]] remoteExec ["commandArtilleryFire", _objVehicle];
	sleep selectRandom[10,30,60,120,240];
};

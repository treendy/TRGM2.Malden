//[_iniVeh, _para, _type] spawn TGM_vd_fnc_handle;
private ["_iniVeh","_para","_type"];
_iniVeh = _this select 0;
_para = _this select 1;
_type = _this select 2;

while {getPos _iniVeh select 2 < 0} do
{
	sleep 0.1;
};
while {getPos _iniVeh select 2 > 1} do
{
	sleep 0.1;
};
detach _iniVeh;
sleep 0.1;
deleteVehicle _para;
_oldPos = getPos _iniVeh;
deleteVehicle _iniVeh;
sleep 0.1;
_veh = createVehicle[_type, _oldPos, [], 0, "NONE"];
if (isServer) then 
{
_spawnpos = _this select 0;
_distance = _this select 1;
_mode = _this select 2;
_dir = (getDir _spawnpos) - 180;
_counter = 0;
_woundcount = 0;

	_Grp = createGroup civilian;
	"C_man_1" createUnit [_spawnpos, _Grp,"victim0 = this"];
	victim0 setDir _dir;
	victim0 disableai "move";
	
	null = [victim0, _spawnpos, _distance, _mode] execVM "Tib_practicePatient\Tib_Check.sqf";	
	
};



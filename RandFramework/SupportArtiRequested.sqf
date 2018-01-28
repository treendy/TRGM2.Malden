//hint str(_this);
//sleep 2;
_artiVeh = _this select 0;


_artiVeh addEventHandler [
	"fired", 
	"[0.1,'Arti round fired'] execVM 'RandFramework\AdjustBadPoints.sqf';hint ""Arti round fired"";"];




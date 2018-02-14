//hint str(_this);
//sleep 2;
_artiVeh = _this select 0;


_artiVeh addEventHandler [
	"fired",
	"[0.1,localize 'STR_TRGM2_SupportArtiRequested_Hint'] execVM 'RandFramework\AdjustBadPoints.sqf';hint (localize ""STR_TRGM2_SupportArtiRequested_Hint"");"];




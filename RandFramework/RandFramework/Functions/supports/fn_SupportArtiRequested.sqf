_artiVeh = _this select 0;
_artiVeh addEventHandler [
	"fired",
	"[0.1,localize 'STR_TRGM2_SupportArtiRequested_Hint'] spawn TREND_fnc_AdjustBadPoints; hint (localize ""STR_TRGM2_SupportArtiRequested_Hint"");"
];

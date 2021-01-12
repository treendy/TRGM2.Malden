format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
sleep 3;
playMusic TREND_IntroMusic;
[format["SelectLoop Music: %1", TREND_IntroMusic ], true] call TREND_fnc_log;

while {!TREND_bAndSoItBegins} do {

	if ((!isNull TREND_AdminPlayer && str player isEqualTo "sl") || (TREND_AdminPlayer isEqualTo player)) then {
		if (!dialog) then {
			sleep 1.5;
			if  (!dialog && !TREND_bOptionsSet) then { //seemed to show dialog twice... so havce added delay and double check its still not showing
				[] spawn TREND_fnc_openDialogMissionSelection;
			};
		};
		sleep 0.5;
	} else {
		if (!TREND_bOptionsSet && {!(TREND_AdminPlayer isEqualTo player)}) then {
			txt1Layer = "txt1" call BIS_fnc_rscLayer;
			_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.5' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_PleaseWait1 Admin " + localize "STR_TRGM2_TRGMInitPlayerLocal_PleaseWait2" + "</t>";
			[_texta, 0, 0.220, 7, 1,0,txt1Layer] spawn BIS_fnc_dynamicText;
		} else {
			if (isNil "sl" && !isNull TREND_AdminPlayer) then {
				txt5Layer = "txt5" call BIS_fnc_rscLayer;
				_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_TopSlotMustFilled" + "</t>";
				[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;
			} else {
				if (!isPlayer sl && !isNull TREND_AdminPlayer) then {
					txt5Layer = "txt5" call BIS_fnc_rscLayer;
					_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_TopSlotMustPlayer" + "</t>";
					[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;
				} else {
					txt1Layer = "txt1" call BIS_fnc_rscLayer;
					_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.5' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_PleaseWait1 Admin " + localize "STR_TRGM2_TRGMInitPlayerLocal_PleaseWait3" + "</t>";
					[_texta, 0, 0.220, 7, 1,0,txt1Layer] spawn BIS_fnc_dynamicText;
				};
			};
		};
	};
	sleep 5;
};
waitUntil {TREND_bOptionsSet};

txt5Layer = "txt5" call BIS_fnc_rscLayer;
_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>TRGM 2</t>";
[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;


txt51Layer = "txt51" call BIS_fnc_rscLayer;
_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.5' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_CantHearMusic" + "</t>";
[_texta, 0, 0.280, 7, 1,0,txt51Layer] spawn BIS_fnc_dynamicText;
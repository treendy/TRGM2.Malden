params ["_thisCiv", "_thisPlayer"];

if (side player == west) then {

	[_thisCiv] remoteExec ["removeAllActions", 0, true];

	if (alive _thisCiv) then {

		_azimuth = _thisCiv getDir _thisPlayer;
		_thisCiv setDir _azimuth;
		_thisCiv switchMove "Acts_StandingSpeakingUnarmed";
		sleep 3;
		[TREND_IntelShownType,"TalkRebLead"] spawn TREND_fnc_showIntel;
		sleep 2;
		[TREND_IntelShownType,"TalkRebLead"] spawn TREND_fnc_showIntel;
		sleep 10;
		_thisCiv switchMove "";

	}
	else {
		hint "This guy doesnt seem to want to speak much in his current state!!!"
	};
};



true;
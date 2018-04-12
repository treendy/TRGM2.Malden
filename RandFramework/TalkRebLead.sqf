

_thisCiv = _this select 0;
_thisPlayer = _this select 1;


if (side player == west) then {

	[_thisCiv] remoteExec ["removeAllActions", 0, true];

	if (alive _thisCiv) then {

		_azimuth = _thisCiv getDir _thisPlayer;
		_thisCiv setDir _azimuth;
		_thisCiv switchMove "Acts_StandingSpeakingUnarmed";
		sleep 3;
		[IntelShownType,"TalkRebLead"] execVM "RandFramework\showIntel.sqf";
		sleep 2;
		[IntelShownType,"TalkRebLead"] execVM "RandFramework\showIntel.sqf";
		sleep 10;
		_thisCiv switchMove "";
		
	}
	else {
		hint "This guy doesnt seem to want to speak much in his current state!!!"
	};
};



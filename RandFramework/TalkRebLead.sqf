params ["_thisCiv","_thisPlayer"];

if (side player == FriendlySide) then {

	[_thisCiv] remoteExec ["removeAllActions", 0, true];

	if (alive _thisCiv) then {

		_azimuth = _thisCiv getDir _thisPlayer;
		[_thisCiv, _azimuth] remoteExec ["setDir", _thisCiv]; //setDir needs the unit to be local, switchMove is only seen where it runs
		[_thisCiv, "Acts_StandingSpeakingUnarmed"] remoteExec ["switchMove", 0];
		sleep 3;
		[IntelShownType,"TalkRebLead"] spawn TRGM_fnc_showIntel;
		sleep 2;
		[IntelShownType,"TalkRebLead"] spawn TRGM_fnc_showIntel;
		sleep 10;
		[_thisCiv, ""] remoteExec ["switchMove", 0];

	}
	else {
		hint "This guy doesnt seem to want to speak much in his current state!!!"
	};
};

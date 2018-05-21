

_bAllow = true;
if (isMultiplayer) then {
	_bSLAlive = false;
	_bK1_1Alive = false;
	if (!isnil "sl") then {
		_bSLAlive = alive sl;
	};
	if (!isnil "k2_1") then {
		_bK1_1Alive = alive k2_1;
	};

	if (_bSLAlive && str(player) != "sl") then {
		hint (localize "STR_TRGM2_attemptendmission_Kilo1");
		_bAllow = false;
	};

	if (!_bSLAlive && _bK1_1Alive && str(player) != "k2_1") then {
		hint (localize "STR_TRGM2_attemptendmission_Kilo2");
		_bAllow = false;
	};
	if (!_bSLAlive && !_bK1_1Alive && (leader (group player))!=player) then {
			hint (localize "STR_TRGM2_attemptendmission_Kilo1");
			_bAllow = false;
	};
};


if (_bAllow) then {
	_mrkHQPos = getMarkerPos "mrkHQ";
	_AOCampPos = getPos endMissionBoard2;
	bAllAtBase2 = ({(alive _x)&&((_x distance _mrkHQPos < 500)||(_x distance _AOCampPos < 500))} count (call BIS_fnc_listPlayers))==({ (alive _x) } count (call BIS_fnc_listPlayers));

	if (SaveType != 0) then {
		[SaveType,false] execVM "RandFramework\Campaign\ServerSave.sqf";
	};

	if (bAllAtBase2) then {
		Hint (localize "STR_TRGM2_exitCampaign_RepSaaved");
		["end4", true, 7] remoteExec ["BIS_fnc_endMission"];
		bAttemptedEnd = false; publicVariable "bAttemptedEnd";
	}
	else {
		Hint (localize "STR_TRGM2_exitCampaign_CampaignSaaved");
	};
};



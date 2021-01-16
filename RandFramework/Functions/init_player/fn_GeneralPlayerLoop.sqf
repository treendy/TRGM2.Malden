format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
while {true} do {
	if (side player != civilian) then {
		if (count TREND_ObjectivePossitions > 0 && TREND_AllowUAVLocateHelp) then {
			if ((Player distance (TREND_ObjectivePossitions select 0)) < 25) then {
				if ((Player getVariable ["calUAVActionID", -1]) == -1) then {
					[(localize "STR_TRGM2_TRGMInitPlayerLocal_UAVAvailable")] call TREND_fnc_notify;
					_actionID = player addAction [localize "STR_TRGM2_TRGMInitPlayerLocal_CallUAV",{[] spawn TREND_fnc_callUAVFindObjective}];
					player setVariable ["calUAVActionID",_actionID];
				};
			};
			//else {
			//	if ((Player getVariable ["calUAVActionID", -1]) != -1) then {
			//		player removeAction (Player getVariable ["calUAVActionID", -1]);
			//		player setVariable ["calUAVActionID", nil];
			//		["UAV no longer available"] call TREND_fnc_notify;
			//	};
			//};
		};
		if (leader (group (vehicle player)) == player && TREND_AdvancedSettings select TREND_ADVSET_SUPPORT_OPTION_IDX == 1) then {
			if (TREND_iMissionSetup == 5) then {
				if (TREND_CampaignInitiated) then {

					_dCurrentRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
					//TESTTEST = format["A:%1 - B:%2 - C:%3",TREND_MaxBadPoints,TREND_BadPoints,_dCurrentRep];
					//[TESTTEST] call TREND_fnc_notify;
					if (_dCurrentRep >= 1) then {
						//["hmm2"] call TREND_fnc_notify;
						[player, supReqSupply] call BIS_fnc_addSupportLink;
						sleep 1;
					};
					if (_dCurrentRep >= 3) then {
						//["hmm2"] call TREND_fnc_notify;
						[player, supReq] call BIS_fnc_addSupportLink;
						sleep 1;
					};
					if (_dCurrentRep >= 7) then {
						//["hmm3"] call TREND_fnc_notify;
						[player, supReqAir] call BIS_fnc_addSupportLink;
						sleep 1;
					};
				};
			}
			else {
				[player, supReqSupply] call BIS_fnc_addSupportLink;
				sleep 1;
				[player, supReq] call BIS_fnc_addSupportLink;
				sleep 1;
				[player, supReqAir] call BIS_fnc_addSupportLink;
				sleep 1;
			}
		};
	};
	sleep 10;
};
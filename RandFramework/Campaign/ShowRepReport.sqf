	
	_totalRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;
	_sRankIcon = "";
	if (_totalRep >= 10) then {_sRankIcon = "<img image='RandFramework\Media\Rank5.jpg' size='3.5' />";};
	if (_totalRep < 10) then {_sRankIcon = "<img image='RandFramework\Media\Rank4.jpg' size='3.5' />";};
	if (_totalRep < 7) then {_sRankIcon = "<img image='RandFramework\Media\Rank3.jpg' size='3.5' />";};
	if (_totalRep < 5) then {_sRankIcon = "<img image='RandFramework\Media\Rank2.jpg' size='3.5' />";};
	if (_totalRep < 3) then {_sRankIcon = "<img image='RandFramework\Media\Rank1b.jpg' size='3.5' />";};
	if (_totalRep <= 0) then {_sRankIcon = "<img image='RandFramework\Media\Rank0.jpg' size='3.5' />";};	
	_sRankMessage = "<t color='#00ff00'>Your current team rank is: </t><br /><br />" + _sRankIcon + "<br /><br />Get to rank 5 for final objective!<br /><br />";

	_sRankMessage = _sRankMessage +  format["TOTAL REP: %1 <br /><br />REASONS SO FAR: <br />%2",_totalRep, BadPointsReason];
	
	//hint parseText _sRankMessage + format["Current cost per life: %1\n\nBad reputation points: %2 out of %3\n\nTOTAL REP: %4 \n\nREASONS SO FAR: \n%5",_iPointsToAdd,BadPoints, MaxBadPoints, _totalRep, BadPointsReason]
	hint parseText _sRankMessage;


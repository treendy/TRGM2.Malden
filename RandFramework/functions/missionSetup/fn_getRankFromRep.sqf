//returns the campaign rank (0-5) for a reputation value
params ["_rep"];

private _rank = 0;
if (_rep >= 10) then {_rank = 5;};
if (_rep < 10) then {_rank = 4;};
if (_rep < 7) then {_rank = 3;};
if (_rep < 5) then {_rank = 2;};
if (_rep < 3) then {_rank = 1;};
if (_rep < 1) then {_rank = 0;};
_rank

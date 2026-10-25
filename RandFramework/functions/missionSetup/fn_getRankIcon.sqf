//returns the structured text <img> tag of the rank icon for a reputation value (note: rep between 0 and 1 shows Rank1b although the rank is 0)
params ["_rep", ["_size", 3.5]];

private _sIcon = "Rank5";
if (_rep < 10) then {_sIcon = "Rank4";};
if (_rep < 7) then {_sIcon = "Rank3";};
if (_rep < 5) then {_sIcon = "Rank2";};
if (_rep < 3) then {_sIcon = "Rank1b";};
if (_rep <= 0) then {_sIcon = "Rank0";};
format["<img image='RandFramework\Media\%1.jpg' size='%2' />", _sIcon, _size]

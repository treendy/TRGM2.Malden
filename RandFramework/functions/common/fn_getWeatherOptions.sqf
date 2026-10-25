//weather types to pick from for the iWeather mission setting (1 = random)
params [["_iWeather",1]];
if (_iWeather == 1) exitWith {[1,1,1,2,2,2,3,3,3,4,5,6,7,7,8,9,10]};
if (_iWeather >= 2 && _iWeather <= 12) exitWith {[_iWeather - 1]};
[1]

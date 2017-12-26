params ["_speaker","_text"];

_target = [0, -2] select isMultiplayer;
[_speaker,_text] remoteExecCall ["sideChat",_target,false];
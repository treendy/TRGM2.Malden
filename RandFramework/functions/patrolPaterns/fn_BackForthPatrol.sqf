//patrol out from _sidePos and back again in different directions
params ["_sidePos","_distFromCent", "_unitCounts","_IncludTeamLeader","_InsurgentSide"];
[_sidePos,_distFromCent,_unitCounts,_IncludTeamLeader,_InsurgentSide,[[1,0],[0,0],[0,-1],[0,0],[-1,0],[0,0],[-1,1],[0,0],[1,1]],true] call TRGM_fnc_offsetPatrol;

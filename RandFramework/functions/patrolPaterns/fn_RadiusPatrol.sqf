//patrol around the edge of a square around _sidePos
params ["_sidePos","_distFromCent", "_unitCounts","_IncludTeamLeader","_InsurgentSide"];
[_sidePos,_distFromCent,_unitCounts,_IncludTeamLeader,_InsurgentSide,[[1,1],[1,0],[1,-1],[0,-1],[-1,-1],[-1,0],[-1,1],[0,1],[1,1]],false] call TRGM_fnc_offsetPatrol;

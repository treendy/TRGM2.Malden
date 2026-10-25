//returns a number that has not been returned before on this machine, use it to build unique marker names
if (isNil "TRGM_markerCounter") then {TRGM_markerCounter = 0;};
TRGM_markerCounter = TRGM_markerCounter + 1;
TRGM_markerCounter

//opens the map with a title and waits until the player clicks a position, which is stored and broadcast in the global variable _varName (client, scheduled)
params ["_varName", "_sTitle"];

titleText [_sTitle, "PLAIN"];
openMap true;
onMapSingleClick format["%1 = _pos; publicVariable '%1'; openMap false; onMapSingleClick '';true;", _varName];
sleep 1;
waitUntil {!visibleMap};

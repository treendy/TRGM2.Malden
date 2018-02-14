

titleText[localize "STR_TRGM2_telePara_SelectPosition", "PLAIN"];
//onMapSingleClick "vehicle player setPos _pos; onMapSingleClick '';true;";
//onMapSingleClick "_para = createVehicle [""Parachute_US_EP1"", _pos, [], 0, ""FLY""];_para setPosATL [getPosATL _para select 0, getPosATL _para select 1, 200];player moveInDriver _para; onMapSingleClick '';true;";
//onMapSingleClick "_para = createVehicle [""Steerable_Parachute_F"", [100,100], [], 0, ""FLY""];_para setPosATL [getPosATL _para select 0, getPosATL _para select 1, 200];player moveInDriver _para; onMapSingleClick '';true;";
onMapSingleClick "_para = createVehicle [""Steerable_Parachute_F"", _pos, [], 0, ""FLY""];_para setPosATL [getPosATL _para select 0, getPosATL _para select 1, 75];player moveInDriver _para; onMapSingleClick '';true;";

/*
_para = createVehicle ["Steerable_Parachute_F", [100,100], [], 0, "FLY"];
_para setPosATL [getPosATL _para select 0, getPosATL _para select 1, 200];
player moveInDriver _para;
*/


titleText[localize "STR_TRGM2_tele_SelectPosition", "PLAIN"];
onMapSingleClick "vehicle player setPos _pos; onMapSingleClick '';true;";


//onMapSingleClick "_para = createVehicle [""Parachute_US_EP1"", _pos, [], 0, ""FLY""];_para setPosATL [getPosATL _para select 0, getPosATL _para select 1, 200];player moveInDriver _para; onMapSingleClick '';true;";


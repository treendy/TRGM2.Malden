params ["_thisCiv","_player"];

[_thisCiv, "MOVE"] remoteExec ["disableAI", _thisCiv]; //AI commands only work where the unit is local (the server for spawned civs)

_hintText = selectRandom [localize "STR_TRGM2_SearchGoodCiv_Result1",localize "STR_TRGM2_SearchGoodCiv_Result2",localize "STR_TRGM2_SearchGoodCiv_Result3"];
hint _hintText;

// allow the civ to walk free again, but wait a few seconds so the player could send him away or restrain him.
sleep 5;
[_thisCiv, "MOVE"] remoteExec ["enableAI", _thisCiv];


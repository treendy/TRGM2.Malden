params ["_thisCiv","_player"];

_thisCiv disableAI "MOVE";

_hintText = selectRandom ["This civilian is ok.","This civilian is not a threat.","You do not find anything."];
hint _hintText;

// allow the civ to walk free again, but wait a few seconds so the player could send him away or restrain him.
sleep 5;
_thisCiv enableAI "MOVE";


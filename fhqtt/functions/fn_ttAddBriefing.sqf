
/* FHQ_fnc_ttAddBriefing: Add a full briefing
 *
 * This functions receives an array as input. The elements of the input array
 * are interpreted as follows:
 * If the element is a two-element array consisting of two strings, the entry is
 * interpreted as a new briefing topic. If the array has three strings, it's interpreted
 * as a new briefing entry, with the first one being the general subject ("Diary" by default),
 * and the two subsequent strings title and description.
 * If the element is anything else, the following topics will only be presented to
 * the units matching the element. For example, if the element is a group, the following
 * entries are added to this group only.
 *
 * NOTE: The old hierarchical filtering is no longer supported. It wasn't that useful for
 * real-world application and was posing severe problems with respawn missions.
 *
 * Example:
 *
 * [
 *     west,
 *        ["Mission", "Get some!"],
 *        ["Enemy Forces", "There's lots of ruskies around"],
 *     east,
 *        ["Mission", "Get those imperialistic americans"],
 *        ["Current Supply of Vodka", "Low"],
 *     {true},
 *        ["Credits", "Mission by", "Some Dude"],
 *        ["Credits", "Uses scripts by", "Some other dude<br/>Yet another dude"]
 * ] call FHQ_fnc_ttAddBriefing.
 *
 * The first two lines (Mission, Enemy Forces), are added under "Briefing" for west
 * troops only, the second two lines (Mission, Current Supply of Vodka) only for east.
 * The last two lines add two new entries "Mission by" and "Uses scripts by" into a new
 * subject "Credits".
 *
 * NOTE: Do not over-use the additional subject feature. Briefing and all associated information
 * should go to the default subject.
 *
 * Calling FHQ_fnc_ttAddBriefing with an already existing subject/title will add a new log entry
 * if the text differs from the previous one.
 *
 * Notifications are shown after the initial briefing has been donwloaded by the clients, i.e.
 * not at mission start, only when new briefing entries are added.
 */

private ["_currentFilter", "_i", "_current", "_x"];
_currentFilter = {true};

if (isServer) then {
    /* Note: Server only code. Briefing entries must be added on the server, not on an
     * individual client
     */

    for [{_i = 0}, {_i < count _this}, {_i = _i + 1}] do {

    	_current = _this select _i;

        if (_current call FHQ_fnc_ttiIsFilter) then {
            _currentFilter = nil;
            _currentFilter = _current;
        } else {
			/* It's a briefing entry. */
            [_currentFilter, _current] call FHQ_fnc_ttiAddBriefingEntry;
        };
	};

	publicVariable "FHQ_TTI_BriefingList";
    if (!isDedicated) then {
   		FHQ_TTI_BriefingList call FHQ_fnc_ttiUpdateBriefingList;
   	};

   	FHQ_TTI_briefing = true;
   	publicVariable "FHQ_TTI_briefing";
};

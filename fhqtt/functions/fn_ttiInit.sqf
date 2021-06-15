/* Internal function, called automatically */
FHQ_TT_subtaskPrefix = " > ";
FHQ_TTI_supressTaskHints = true;
FHQ_TTI_is_arma3 = true;
FHQ_TTI_version = productVersion select 2;

if (isClass (configfile >> "CfgAddons" >> "PreloadAddons" >> "A3")) then {
    FHQ_TTI_is_arma3 = true;
};

if (isServer) then
{
    FHQ_TTI_BriefingList = [];
      FHQ_TTI_TaskList = [];
};

if (!isDedicated) then
{
    FHQ_TTI_ClientTaskList = [];

    if (isNil {player} || isNull player) then
    {
       FHQ_TTI_isJIPPlayer = true;
    };

    [] spawn
    {
        // Wait for join in progress
          waitUntil {!isNil {player}};
           waitUntil {!isNull player};


        /* Wait until briefing is ready (on server).
         * Note that we spawn this code, to cope with the possibility of having no briefing at all
         */
        [] spawn {
            waitUntil {!isNil "FHQ_TTI_briefing"};
            FHQ_TTI_BriefingList call FHQ_fnc_ttiUpdateBriefingList;
            "FHQ_TTI_BriefingList" addPublicVariableEventHandler {(_this select 1) call FHQ_fnc_ttiUpdateBriefingList};
        };

        // Wait until the task list is ready (on server)
        waitUntil {!isNil "FHQ_TTI_tasks"};
        FHQ_TTI_TaskList call FHQ_fnc_ttiUpdateTaskList;
        "FHQ_TTI_TaskList" addPublicVariableEventHandler {(_this select 1) call FHQ_fnc_ttiUpdateTaskList};

        FHQ_TTI_supressTaskHints = false;
    };
};

true;

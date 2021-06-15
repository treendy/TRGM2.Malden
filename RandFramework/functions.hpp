class TRGM_SERVER {
    class init {
        file = "RandFramework\Server\init";
        class checkAnyPlayersAlive {};
        class createNeededObjects {};
        class initUnitVars {};
        class main {};
        class playBaseRadioEffect {};
        class sandStormEffect {};
        class serverSave {};
        class setTimeAndWeather {};
        class weatherAffectsAI {};
    };

    class campaign {
        file = "RandFramework\Server\campaign";
        class initCampaign {};
        class exitCampaign {};
        class recruiteInf {};
        class setMissionBoardOptions {};
        class turnInMission {};
    };

    class mission {
        file = "RandFramework\Server\mission";
        class attemptEndMission {};
        class finalSetupCleaner {};
        class initMissionVars {};
        class populateSideMission {};
        class postStartMission {};
        class quitMission {};
        class startInfMission {};
        class startMission {};
        class startMissionPreCheck {};
        class endMission {};
    };

    class objectives {
        file = "RandFramework\Server\objectives";
        class aoCampCreator {};
        class bugRadio {};
        class commsBlocked {};
        class hackIntel {};
        class occupyHouses {};
        class setATMineEvent {};
        class setCheckpoint {};
        class setDownCivCarEvent {};
        class setDownConvoyEvent {};
        class setDownedChopperEvent {};
        class setFireFightEvent {};
        class setIEDEvent {};
        class setMedicalEvent {};
        class setOtherAreaStuff {};
        class setTargetEvent {};
        class speakToFriendlyCheckpoint {};
        class updateTask {};
    };

    class units {
        file = "RandFramework\Server\units";
        class alertNearbyUnits {};
        class backForthPatrol {};
        class badCiv {};
        class badCivAddSearchAction {};
        class badCivApplyAssingnedArmament {};
        class badCivInitialize {};
        class badCivLoop {};
        class badCivRemoveSearchAction {};
        class badCivSearch {};
        class badCivTurnHostile {};
        class badReb {};
        class buildingPatrol {};
        class civKilled {};
        class createEnemySniper {};
        class createUnit {};
        class createWaitingAmbush {};
        class createWaitingSuicideBomber {};
        class findOverwatchOverride {};
        class hvtWalkAround {};
        class insKilled {};
        class interrogateOfficer {};
        class paramedicKilled {};
        class radiusPatrol {};
        class searchGoodCiv {};
        class spawnCivs {};
        class spawnPatrolUnit {};
        class speakInformant {};
        class talkRebLead {};
        class zenOccupyHouse {};
    };
};

class TRGM_GLOBAL {
    class init {
        file = "RandFramework\Global\init";
        class initGlobalVars {};
    };

    class logging {
        file = "RandFramework\Global\logging";
        class log {};
        class notify {};
        class notifyGlobal {};
        class populateLoadingWait {};
    };

    class common {
        file = "RandFramework\Global\common";
        class addPlayerActionPersistent {};
        class animateAnimals {};
        class callNearbyPatrol {};
        class callUAVFindObjective {};
        class carryAndJoinWounded {};
        class convoy {};
        class createConvoy {};
        class debugDotMarker {};
        class deleteTrash {};
        class enemyAirSupport {};
        class fireAOFlares {};
        class fireIllumFlares {};
        class hideTerrainObjects {};
        class initAmmoBox {};
        class isAceLoaded {};
        class isCbaLoaded {};
        class nvScript {};
        class para {};
        class paraDrop {};
        class pushObject {};
        class reinforcements {};
        class setLoadout {};
        class setCustomLoadout {};
        class setMilitiaSkill {};
        class showIntel {};
        class unloadDingy {};
    };

    class factions {
        file = "RandFramework\Global\factions";
        class appendAdditonalFactionData {};
        class buildEnemyFaction {};
        class buildFriendlyFaction {};
        class getFactionDataBySide {};
        class getFactionVehicle {};
        class getUnitArraysFromUnitData {};
        class getUnitDataByFaction {};
        class getVehicleArraysFromVehData {};
        class getVehicleDataByFaction {};
        class isAmmo {};
        class isArmed {};
        class isFuel {};
        class isMedical {};
        class isRepair {};
        class isTransport {};
    };

    class location {
        file = "RandFramework\Global\location";
        class addToDirection {}; //Can add degrees to direction to calcuate final direction
        class directionToText {};
        class findSafePos {};
        class getLocationName {};
        class randomPosIntersection {};
    };

    class reputation {
        file = "RandFramework\Global\reputation";
        class adjustBadPoints {};
        class adjustMaxBadPoints {};
        class checkBadPoints {};
        class countSpentPoints {};
        class showRepReport {};
    };

    class transport {
        file = "RandFramework\Global\transport";
        class addTransportActions {};
        class addTransportActionsPlayer {};
        class addTransportActionsVehicle {};
        class checkMissionIdActive {};
        class commsHQ {};
        class commsPilotToVehicle {};
        class commsSide {};
        class flyToBase {};
        class flyToLz {};
        class getTransportName {};
        class helicopterIsFlying {};
        class isOnlyBoardCrewOnboard {};
        class selectLz {};
        class selectLzCreateBolckedAreaMarker {};
        class selectLzOnMapClick {};
    };
};

class TRGM_GUI {
    class gui {
        file = "RandFramework\GUI";
        class codeCompare {};
        class createNotification {};
        class deleteNotification {};
        class downloadData {};
        class handleNotification {};
        class initNotifications {};
        class missionTypeSelection {};
        class openDialogAdvancedMissionSettings {};
        class openDialogEnemyFaction {};
        class openDialogMissionSelection {};
        class openDialogRequests {};
        class openDialogTeamLoadouts {};
        class openVehicleCustomizationDialog {};
        class setParamsAndBegin {};
        class timeSliderOnChange {};
        class wireCompare {};
    };
};

class TRGM_CLIENT {
    class init {
        file = "RandFramework\Client\init";
        class checkKilledRange {};
        class drawKilledRanges {};
        class generalPlayerLoop {};
        class inSafeZone {};
        class findValidHQPosition {};
        class main {};
        class missionSelectLoop {};
        class onlyAllowDirectMapDraw {};
        class playerScripts {};
        class setNVG {};
        class startingMove {};
    };

    class camera {
        file = "RandFramework\Client\camera";
        class endCamera {};
        class introCamera {};
        class missionOverAnimation {};
        class missionSetupCamera {};
    };

    class supports {
        file = "RandFramework\Client\supports";
        class airSupportRequested {};
        class supplyDropCrateInit {};
        class supplyDropVehInit {};
        class supportArtiRequested {};
        class transferProviders {};
    };
};

class MISSIONS {
    class main {
		class ambushConvoyMission {
			file = "RandFramework\Missions\ambushConvoyMission.sqf";
		};
		class bombDisposalMission {
			file = "RandFramework\Missions\bombDisposalMission.sqf";
		};
		class bugRadioMission {
			file = "RandFramework\Missions\bugRadioMission.sqf";
		};
		class customMissionBasicCacheSample {
			file = "RandFramework\Missions\customMissionBasicCacheSample.sqf";
		};
		class defuseIEDsMission {
			file = "RandFramework\Missions\defuseIEDsMission.sqf";
		};
		class destroyCacheMission {
			file = "RandFramework\Missions\destroyCacheMission.sqf";
		};
		class destroyVehiclesMission {
			file = "RandFramework\Missions\destroyVehiclesMission.sqf";
		};
		class hackDataMission {
			file = "RandFramework\Missions\hackDataMission.sqf";
		};
		class hvtMission {
			file = "RandFramework\Missions\hvtMission.sqf";
		};
		class meetingAssassinationMission {
			file = "RandFramework\Missions\meetingAssassinationMission.sqf";
		};
		class searchAndDestroyMission {
			file = "RandFramework\Missions\searchAndDestroyMission.sqf";
		};
		class secureAndResupplyMission {
			file = "RandFramework\Missions\secureAndResupplyMission.sqf";
		};
		class stealDataFromResearchVehMission {
			file = "RandFramework\Missions\stealDataFromResearchVehMission.sqf";
		};
    };
};
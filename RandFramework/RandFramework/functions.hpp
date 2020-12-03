class TREND {

    class init {
        file = "RandFramework\Functions\init";
        class initGlobalVars {};
        class initUnitVars {};
        class mainInit {};
        class getFactionDataBySide {};
        class getUnitDataByFaction {};
        // class getUnitArraysFromUnitData {};
        class isArmed {};
        class getVehicleDataByFaction {};
        // class getVehicleArraysFromVehData {};
        class buildEnemyFaction {};
        class buildFriendlyFaction {};
        class findValidHQPosition{};
        class createNeededObjects{};
        class attemptEndMission{};
        class endMission{};
    };

    class common {
        file = "RandFramework\functions\common";
        class isAceLoaded {};
        class isCbaLoaded {};

        class AdjustBadPoints{};
        class AdjustMaxBadPoints{};
        class setLoadout {};
        class getFactionVehicle{};

        class setMilitiaSkill {};
        class debugDotMarker {};
        class CountSpentPoints {};
        class AddToDirection {}; //Can add degrees to direction to calcuate final direction
        class addPlayerActionPersistent {};

        class showIntel{};
        class CarryAndJoinWounded{};
        class animateAnimals{};

        class fireIllumFlares{};
        class fireAOFlares{};
        class callUAVFindObjective{};

        class CallNearbyPatrol{};
        class reinforcements{};
        class enemyAirSupport{};

        class NVscript{};
        class UnloadDingy{};
        class PushObject{};
        class hideTerrainObjects{};
    };

    class supports {
        file = "RandFramework\functions\supports";
        class AirSupportRequested{};
        class SupplyDropCrateInit{};
        class SupplyDropVehInit{};
        class SupportArtiRequested{};
    };

    class gui {
        file = "RandFramework\GUI";
        class SetParamsAndBegin{};
        class MissionTypeSelection{};
        class openDialogAdvancedMissionSettings{};
        class openDialogEnemyFaction{};
        class openDialogMissionSelection{};
        class openDialogTeamLoadouts{};

        class codeCompare{};
        class wireCompare{};

        class openDialogRequests{};
    };

    class missions {
        file = "RandFramework\functions\missions";

        class ServerSave {};
        class SetTimeAndWeather {};

        class initCampaign {};
        class exitCampaign {};
        class initMissionVars {};

        class StartMission {};
        class startInfMission {};
        class PostStartMission {};
        class StartMissionPreCheck {};
        class QuitMission {};
        class FinalSetupCleaner{};

        class AoCampCreator {};
        class PopulateSideMission{};

        class RecruiteInf {};
        class ShowRepReport {};
        class TurnInMission {};
        class SetMissionBoardOptions {};
        class setOtherAreaStuff{};

        class createEnemySniper {};
        class findOverwatchOverride {};
        class setCheckpoint {};
        class OccupyHouses{};
        class SpeakToFriendlyCheckpoint{};
        class createWaitingAmbush{};
        class createWaitingSuicideBomber{};
        class setIEDEvent{};
        class hackIntel1{};
        class downloadResearchData{};
        class commsBlocked{};
        class setMedicalEvent{};
        class setDownedChopperEvent{};
        class setDownConvoyEvent{};
        class setDownCivCarEvent{};
        class setTargetEvent{};
        class setATMineEvent{};
        class setFireFightEvent{};
        class bugRadio1{};
    };

    class location {
        file = "RandFramework\functions\location";

        class directionToText {};
        class getLocationName {};
    };

    class transport { // CATEGORY
        file = "RandFramework\functions\transport";

        class isOnlyBoardCrewOnboard {};
        class checkMissionIdActive {};

        class commsPilotToVehicle{};
        class commsSide{};
        class commsHQ{};


        class selectLZ{};
        class selectLzCreateBolckedAreaMarker{};
        class selectLzOnMapClick{};

        class addTransportActions{};
        class addTransportActionsVehicle{};
        class addTransportActionsPlayer{};

        class getTransportName{};


        class flyToLz{};
        class flyToBase{};

        class helicopterIsFlying{};
    };

    class civillians { // CATEGORY
        file = "RandFramework\functions\civillians";

        class SpawnCivs {};
        class badReb{};
        class badCiv{};
        class badCivInitialize{};
        class badCivApplyAssingnedArmament{};
        class badCivSearch{};
        class badCivTurnHostile{};
        class badCivLoop{};
        class badCivAddSearchAction{};
        class badCivRemoveSearchAction{};
        class TalkRebLead{};
        class InsKilled{};
        class CivKilled{};
        class ParamedicKilled{};
        class SearchGoodCiv{};
        class IdentifyHVT{};
        class SpeakInformant{};
        class interrogateOfficer{};
    };

    class enemyUnits {
        file = "RandFramework\functions\enemyUnits";
        class CreateUnit{};
        class SpawnPatrolUnit{};
        class HVTWalkAround {};
        class Zen_OccupyHouse {};
    };

    class patrolPaterns {
        file = "RandFramework\functions\patrolPaterns";
        class BackForthPatrol{};
        class BuildingPatrol{};
        class RadiusPatrol{};
    };

};
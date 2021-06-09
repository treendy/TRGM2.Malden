class TREND {

    class logging {
        file = "RandFramework\Functions\logging";
        class log {};
        class notify {};
        class notifyGlobal {};
    };

    class init {
        file = "RandFramework\Functions\init";
        class attemptEndMission {};
        class createNeededObjects {};
        class endMission {};
        class findValidHQPosition {};
        class initGlobalVars {};
        class InitPostStarted {};
        class initUnitVars {};
        class mainInit {};
        class ServerSave {};
        class SetTimeAndWeather {};
    };

    class init_player {
        file = "RandFramework\Functions\init_player";
        class checkKilledRange {};
        class drawKilledRanges {};
        class GeneralPlayerLoop {};
        class InSafeZone {};
        class introCamera {};
        class mainInitLocal {};
        class MissionOverAnimation {};
        class MissionSelectLoop {};
        class OnlyAllowDirectMapDraw {};
        class setNVG {};
        class startingMove {};
    };

    class factions {
        file = "RandFramework\Functions\factions";
        class buildEnemyFaction {};
        class buildFriendlyFaction {};
        class getFactionDataBySide {};
        // class getUnitArraysFromUnitData {}; // These were not returning their values when called for some reason, instead they are hard-coded for now in the buildXFaction functions.
        class getUnitDataByFaction {};
        // class getVehicleArraysFromVehData {}; // These were not returning their values when called for some reason, instead they are hard-coded for now in the buildXFaction functions.
        class getVehicleDataByFaction {};
        class isAmmo {};
        class isArmed {};
        class isFuel {};
        class isMedical {};
        class isRepair {};
        class isTransport{};
    };

    class common {
        file = "RandFramework\functions\common";
        class addPlayerActionPersistent {};
        class animateAnimals{};
        class CallNearbyPatrol{};
        class callUAVFindObjective{};
        class CarryAndJoinWounded{};
        class convoy{};
        class createConvoy{};
        class debugDotMarker {};
        class deleteTrash {};
        class enemyAirSupport{};
        class fireAOFlares{};
        class fireIllumFlares{};
        class getFactionVehicle{};
        class hideTerrainObjects{};
        class initAmmoBox{};
        class isAceLoaded {};
        class isCbaLoaded {};
        class NVscript{};
        class paraDrop{};
        class PushObject{};
        class reinforcements{};
        class setLoadout {};
        class setCustomLoadout {};
        class setMilitiaSkill {};
        class showIntel{};
        class UnloadDingy{};
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
        class codeCompare{};
        class createNotification{};
        class deleteNotification{};
        class downloadData{};
        class handleNotification{};
        class initNotifications {};
        class MissionTypeSelection{};
        class openDialogAdvancedMissionSettings{};
        class openDialogEnemyFaction{};
        class openDialogMissionSelection{};
        class openDialogRequests{};
        class openDialogTeamLoadouts{};
        class openVehicleCustomizationDialog{};
        class SetParamsAndBegin{};
        class timeSliderOnChange{};
        class wireCompare{};
    };

    class campaign {
        file = "RandFramework\functions\campaign";
        class initCampaign {};
        class exitCampaign {};
        class RecruiteInf {};
        class SetMissionBoardOptions {};
        class TurnInMission {};
    };

    class mission {
        file = "RandFramework\functions\mission";
        class FinalSetupCleaner{};
        class initMissionVars {};
        class PopulateSideMission{};
        class PostStartMission {};
        class QuitMission {};
        class startInfMission {};
        class StartMission {};
        class StartMissionPreCheck {};
    };

    class reputation {
        file = "RandFramework\functions\reputation";
        class AdjustBadPoints{};
        class AdjustMaxBadPoints{};
        class CheckBadPoints{};
        class CountSpentPoints {};
        class ShowRepReport {};
    };

    class objectives {
        file = "RandFramework\functions\objectives";
        class AoCampCreator {};
        class bugRadio1{};
        class commsBlocked{};
        class hackIntel1{};
        class OccupyHouses{};
        class setATMineEvent{};
        class setCheckpoint {};
        class setDownCivCarEvent{};
        class setDownConvoyEvent{};
        class setDownedChopperEvent{};
        class setFireFightEvent{};
        class setIEDEvent{};
        class setMedicalEvent{};
        class setOtherAreaStuff{};
        class setTargetEvent{};
        class SpeakToFriendlyCheckpoint{};
        class updateTask{};
    };

    class location {
        file = "RandFramework\functions\location";
        class AddToDirection {}; //Can add degrees to direction to calcuate final direction
        class directionToText {};
        class findSafePos{};
        class getLocationName {};
        class randomPosIntersection{};
    };

    class transport { // CATEGORY
        file = "RandFramework\functions\transport";
        class addTransportActions{};
        class addTransportActionsPlayer{};
        class addTransportActionsVehicle{};
        class checkMissionIdActive {};
        class commsHQ{};
        class commsPilotToVehicle{};
        class commsSide{};
        class flyToBase{};
        class flyToLz{};
        class getTransportName{};
        class helicopterIsFlying{};
        class isOnlyBoardCrewOnboard {};
        class selectLZ{};
        class selectLzCreateBolckedAreaMarker{};
        class selectLzOnMapClick{};
    };

    class civillians { // CATEGORY
        file = "RandFramework\functions\civillians";
        class badCiv{};
        class badCivAddSearchAction{};
        class badCivApplyAssingnedArmament{};
        class badCivInitialize{};
        class badCivLoop{};
        class badCivRemoveSearchAction{};
        class badCivSearch{};
        class badCivTurnHostile{};
        class badReb{};
        class CivKilled{};
        class InsKilled{};
        class InterrogateOfficer{};
        class ParamedicKilled{};
        class SearchGoodCiv{};
        class SpawnCivs {};
        class SpeakInformant{};
        class TalkRebLead{};
    };

    class enemyUnits {
        file = "RandFramework\functions\enemyUnits";
        class alertNearbyUnits {};
        class createEnemySniper {};
        class CreateUnit{};
        class createWaitingAmbush{};
        class createWaitingSuicideBomber{};
        class findOverwatchOverride {};
        class HVTWalkAround {};
        class SpawnPatrolUnit{};
        class Zen_OccupyHouse {};
    };

    class patrolPaterns {
        file = "RandFramework\functions\patrolPaterns";
        class BackForthPatrol{};
        class BuildingPatrol{};
        class RadiusPatrol{};
    };

};
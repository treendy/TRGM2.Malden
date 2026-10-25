class TRGM   { // TAG

    class common { // CATEGORY
        file = "RandFramework\functions\common";

        class isAceLoaded {};
        class isCbaLoaded {};

        class debugDotMarker {};
        class CountSpentPoints {};
        class AddToDirection {}; //Can add degrees to direction to calcuate final direction
        class addPlayerActionPersistent {};
        class hvtWalkAround {};
        class walkingGuyLoop {};
        class nextMarkerId {};
        class medicalFlashLights {};
        class getWeatherOptions {};
        class adjustBadPoints {};
        class adjustMaxBadPoints {};
        class radioChatterLoop {};
        class artilleryFireLoop {};
    };

    class location { // CATEGORY
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

        class badCivInitialize{};
        class badCivApplyAssingnedArmament{};
        class badCivSearch{};
        class badCivTurnHostile{};
        class badCivLoop{};
        class badCivAddSearchAction{};
        class badCivRemoveSearchAction{};
    };

    class enemyUnits {
        file = "RandFramework\functions\enemyUnits";
        class CreateUnit{};
        class SpawnPatrolUnit{};
    };

    class patrolPaterns {
        file = "RandFramework\functions\patrolPaterns";
        class BackForthPatrol{};
        class BuildingPatrol{};
        class RadiusPatrol{};
        class offsetPatrol{};
    };

    class events {
        file = "RandFramework\functions\events";
        class findRoadWithDirection {};
        class spawnEventThreats {};
        class createEventMarker {};
        class damageRandomWheels {};
        class waveDownPlayer {};
        class createWoundedCasualty {};
        class createTreatingMedic {};
        class medicalParamedicLight {};
        class eventFlareLoop {};
    };

    class missionSetup {
        file = "RandFramework\functions\missionSetup";
        class createObjectiveClearedTrigger {};
        class createObjectiveVehicle {};
        class getRankFromRep {};
        class getRankIcon {};
        class setEnemySandstormSkill {};
        class selectMapPosition {};
        class isPlayerAllowedToLead {};
        class resetTransportChoppers {};
        class showLayerText {};
    };

    //scripts that are run many times, precompiled instead of execVM
    class scripts {
        class setCheckpoint { file = "RandFramework\setCheckpoint.sqf"; };
        class setIEDEvent { file = "RandFramework\setIEDEvent.sqf"; };
        class CivKilled { file = "RandFramework\CivKilled.sqf"; };
        class showIntel { file = "RandFramework\showIntel.sqf"; };
        class setTargetEvent { file = "RandFramework\setTargetEvent.sqf"; };
        class createWaitingSuicideBomber { file = "RandFramework\createWaitingSuicideBomber.sqf"; };
        class createEnemySniper { file = "RandFramework\RandScript\createEnemySniper.sqf"; };
        class setDownCivCarEvent { file = "RandFramework\setDownCivCarEvent.sqf"; };
        class createWaitingAmbush { file = "RandFramework\createWaitingAmbush.sqf"; };
        class setLoadout { file = "RandFramework\setLoadout.sqf"; };
        class setDownedChopperEvent { file = "RandFramework\setDownedChopperEvent.sqf"; };
        class fireAOFlares { file = "RandFramework\RandScript\fireAOFlares.sqf"; };
        class InsKilled { file = "RandFramework\InsKilled.sqf"; };
        class setATMineEvent { file = "RandFramework\setATMineEvent.sqf"; };
        class reinforcements { file = "RandFramework\reinforcements.sqf"; };
        class Zen_OccupyHouse { file = "RandFramework\Zen_OccupyHouse.sqf"; };
        class ParamedicKilled { file = "RandFramework\ParamedicKilled.sqf"; };
        class setMedicalEvent { file = "RandFramework\setMedicalEvent.sqf"; };
        class setDownConvoyEvent { file = "RandFramework\setDownConvoyEvent.sqf"; };
        class enemyAirSupport { file = "RandFramework\RandScript\enemyAirSupport.sqf"; };
        class setFireFightEvent { file = "RandFramework\setFireFightEvent.sqf"; };
        class BadReb { file = "RandFramework\BadReb.sqf"; };
    };
};

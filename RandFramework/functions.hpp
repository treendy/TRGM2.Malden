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
    }
};  
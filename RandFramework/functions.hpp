class TRGM   { // TAG

    class common { // CATEGORY
        file = "RandFramework\functions\common";

        class setMilitiaSkill {};
        class debugDotMarker {};
        class CountSpentPoints {};
        class AddToDirection {}; //Can add degrees to direction to calcuate final direction
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

        class addTransportAction{};

        class flyToLz{};
        class flyToBase{};
        
        class helicopterIsFlying{};
    };

    
    class civillians { // CATEGORY
        file = "RandFramework\functions\civillians";

        class badCivInitialize{};
        class badCivApplyAssignedArmament{};
        class badCivSearch{};
        class badCivTurnHostile{};
        class badCivLoop{};
        class badCivAddSearchAction{};
        class badCivRemoveSearchAction{};
    };
};  
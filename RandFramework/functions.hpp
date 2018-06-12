class TRGM   { // TAG

    class common { // CATEGORY
        file = "RandFramework\functions\common";

        class isAceLoaded {};
        class isCbaLoaded {};

        class setMilitiaSkill {};
        class debugDotMarker {};
        class CountSpentPoints {};
        class AddToDirection {}; //Can add degrees to direction to calcuate final direction
        class addPlayerActionPersistent {};
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
};  
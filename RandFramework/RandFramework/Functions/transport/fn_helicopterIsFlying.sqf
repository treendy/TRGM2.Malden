params ["_vehicle"];

!((isTouchingGround _vehicle)  ||  ((getPos _vehicle select 2) < 2 && (speed _vehicle) < 1));


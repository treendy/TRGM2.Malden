// by ALIAS

if (!hasInterface) exitWith {};
if (!al_monsoon_om) exitwith {};

waitUntil {sleep 1; rain > 0.3};
_rain_drops_eff = "#particlesource" createVehicleLocal position player;
_rain_drops_eff setParticleCircle [20, [0, 0, 0]]; 
_rain_drops_eff setParticleRandom [0.2,[20,20,0],[0,0,1],13,0.5,[0,0,0,0],1,0]; 
_rain_drops_eff setParticleParams [["\A3\Data_F_Mark\ParticleEffects\Universal\waterBallonExplode_01",4,0,16,0],"", "Billboard", 1,0.4,[0,0,0],[0,0,0.5],0,18,7.9,0,[0.05,0.6],[[0.5,0.5,0.5,1],[0.5,0.5,0.5,1]],[2],1,0,"","",vehicle player,0,true];  
_rain_drops_eff setDropInterval 0.001;
waitUntil {sleep 1; rain < 0.3};
deleteVehicle _rain_drops_eff;
if (isMultiplayer) then
{
	waitUntil {!(isNull (findDisplay 46))};
	
	player setspeaker "NoVoice";
	//ShowRad = showRadio false;
	//EnabRad = enableRadio false;
	player disableConversation true;
	
	player addEventHandler 
	[
	"respawn",
		{
		player setspeaker "NoVoice"; 
		//ShowRad = showRadio false;
		//EnabRad = enableRadio false;
		player disableConversation true
		}
	];
};
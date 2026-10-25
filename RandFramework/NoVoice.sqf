if (isMultiplayer) then
{
	waitUntil {!(isNull (findDisplay 46))};
	
	player setspeaker "NoVoice";
	player disableConversation true;
	
	player addEventHandler 
	[
	"respawn",
		{
		player setspeaker "NoVoice"; 
		player disableConversation true
		}
	];
};
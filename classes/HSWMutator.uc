class HSWMutator extends Mutator;

var bool bHasInteraction;
 
function PreBeginPlay()
{
	//Log("ICU Mutator Started"); // Always comment out your logs unless they're errors
}
 
simulated function Tick(float DeltaTime)
{
	local PlayerController PC;
 
	// If the player has an interaction already, exit function.
	if (bHasInteraction)
		Return;
	PC = Level.GetLocalPlayerController();
 
	// Run a check to see whether this mutator should create an interaction for the player
	if ( PC != None)
	{
		PC.Player.InteractionMaster.AddInteraction("HUDStopWatch.StopWatchInteraction", PC.Player); // Create the interaction
		bHasInteraction = True; // Set the variable so this lot isn't called again
	}
}
 
DefaultProperties
{
    GroupName="KFHudStopwatch"
    FriendlyName= "HUD Stopwatch v1.0"
    Description= "Displays a stopwatch on the player's HUD"
    RemoteRole=ROLE_SimulatedProxy
    bAlwaysRelevant=true
}

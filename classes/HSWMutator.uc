class HSWMutator extends Mutator;

var bool bHasInteraction;

function PostBeginPlay() {
    if (KFGameType(Level.Game) == none) {
        Destroy();
        return;
    }
    
    AddToPackageMap("HudStopWatch");
}
 
simulated function Tick(float DeltaTime) {
    local PlayerController PC;
 
    PC = Level.GetLocalPlayerController();
    if (PC != None) { 
        PC.Player.InteractionMaster.AddInteraction("HUDStopWatch.StopWatchInteraction"
            ,PC.Player);
    }
    Disable('Tick');
}
 
defaultproperties {
    GroupName="KFHudStopwatch"
    FriendlyName= "HUD Stopwatch v1.0"
    Description= "Displays a stopwatch on the player's HUD"
    RemoteRole=ROLE_SimulatedProxy
    bAlwaysRelevant=true
}

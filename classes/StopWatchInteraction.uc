class StopWatchInteraction extends Interaction;

var float startTime;
var float elapsedTime, xPos, yPos;

event NotifyLevelChange(){
    Master.RemoveInteraction(self);
}

function Tick (float DeltaTime) {
    elapsedTime= ViewportOwner.Actor.GetEntryLevel().TimeSeconds - startTime;
}

function bool KeyEvent(EInputKey Key, EInputAction Action, float Delta ) {
    local string alias;

    if (Action == IST_Press) {
        alias= ViewportOwner.Actor.ConsoleCommand("KEYBINDING"@ViewportOwner.Actor.ConsoleCommand("KEYNAME"@Key));
        if (alias == class'HSWKeyBinding'.default.KeyData[1].Alias) {
            bVisible= !bVisible;
        } else if (alias == class'HSWKeyBinding'.default.KeyData[2].Alias) {
            if (IsInState('Start')) {
                GotoState('');
            } else {
                GotoState('Start');
            }
        } else if (alias == class'HSWKeyBinding'.default.KeyData[3].Alias) {
            elapsedTime= 0;
        }
    }
 
    return false;
}

state Start {
    function BeginState() {
        startTime= ViewportOwner.Actor.GetEntryLevel().TimeSeconds;
        bRequiresTick= true;
    }

    function EndState() {
        bRequiresTick= false;
    }
}

function PostRender (canvas Canvas) {
    local int min;
    local float sec;
    local string elapsedTimeStr;

    min= elapsedTime / 60;
    sec= elapsedTime - (min * 60);
    if (min < 10) {
        elapsedTimeStr="0";
    }
    elapsedTimeStr$= string(min)$":";
    if (sec < 10) {
        elapsedTimeStr$= "0";
    }
    elapsedTimeStr$=sec;

    Canvas.SetPos(Canvas.SizeX*xPos, Canvas.SizeY*yPos);
    Canvas.Style = 3;
    Canvas.SetDrawColor(0,255,0);
    Canvas.DrawText(elapsedTimeStr);
}

defaultproperties {
    xPos= 0.95
    yPos= 0.15
    bActive= true
}

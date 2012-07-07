class StopWatchInteraction extends Interaction;

var float timer, xPos, yPos;

function Tick (float DeltaTime) {
    timer+= DeltaTime;
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
            timer= 0;
        }
    }
 
    return false;
}

state Start {
    function BeginState() {
        bRequiresTick= true;
    }

    function EndState() {
        bRequiresTick= false;
    }
}

function PostRender (canvas Canvas) {
    local int min;
    local float sec;
    local string timerStr;

    min= timer / 60;
    sec= timer - min;
    if (min < 10) {
        timerStr="0";
    }
    timerStr$= string(min)$":";
    if (sec < 10) {
        timerStr$= "0";
    }
    timerStr$=sec;

    Canvas.SetPos(Canvas.SizeX*xPos, Canvas.SizeY*yPos);
    Canvas.Style = 3;
    Canvas.SetDrawColor(0,255,0);
    Canvas.DrawText(timerStr);
}

defaultproperties {
    xPos= 0.95
    yPos= 0.15
    bActive= true
}

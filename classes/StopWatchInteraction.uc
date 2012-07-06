class StopWatchInteraction extends Interaction;

var float time, xPos, yPos;

event Initialized() {
    super.Initialized();
    GotoState('Stop');
}

function Tick (float DeltaTime) {
    time+= DeltaTime;
}

function bool KeyEvent(EInputKey Key, EInputAction Action, float Delta ) {
    if (Action == IST_Press && Key == IK_Home) {
        bVisible= !bVisible;
    }
 
    return false;
}

auto state Stop {
    function BeginState() {
        time= 0;
    }

    function bool KeyEvent(EInputKey Key, EInputAction Action, float Delta ) {
        if (Action == IST_Press) {
            if (Key == IK_End) {
                GotoState('Start');
            } else {
                return Global.KeyEvent(Key, Action, Delta);
            }
        }
        return false;
    }
}

state Start {
    function BeginState() {
        bRequiresTick= true;
    }

    function bool KeyEvent(EInputKey Key, EInputAction Action, float Delta ) {
        if (Action == IST_Press) {
            if (Key == IK_End) {
                GotoState('Pause');
            } else {
                return Global.KeyEvent(Key, Action, Delta);
            }
        }
        return false;
    }

    function EndState() {
        bRequiresTick= false;
    }
}

state Pause {
    function BeginState() {
        bRequiresTick= false;
    }

    function bool KeyEvent(EInputKey Key, EInputAction Action, float Delta ) {
        if (Action == IST_Press) {
            if (Key == IK_End) {
                bRequiresTick= true;
                GotoState('Start');
            } else if (Key == IK_Delete) {
                GotoState('Stop');
            } else {
                return Global.KeyEvent(Key, Action, Delta);
            }
        }
        return false;
    }
}

function PostRender (canvas Canvas) {
    local int min;
    local float sec;
    local string timeStr;

    min= time / 60;
    sec= time - min;
    if (min < 10) {
        timeStr="0";
    }
    timeStr$= string(min)$":";
    if (sec < 10) {
        timeStr$= "0";
    }
    timeStr$=sec;

    Canvas.SetPos(Canvas.SizeX*xPos, Canvas.SizeY*yPos);
    Canvas.Style = 3;
    Canvas.SetDrawColor(0,255,0);
    Canvas.DrawText(timeStr);
}

defaultproperties {
    xPos= 0.95
    yPos= 0.15
    bActive= true
}

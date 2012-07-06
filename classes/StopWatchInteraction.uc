class StopWatchInteraction extends Interaction;

function bool KeyEvent(EInputKey Key, EInputAction Action, float Delta ) {
    if (Action == IST_Press && Key == IK_PageDown)
        ViewportOwner.Actor.ClientMessage("Key PRESSED:" @ Key);
 
    return false;
}

function PostRender (canvas Canvas) {
    Canvas.SetPos(Canvas.SizeX/2, Canvas.SizeY/2);
    Canvas.Style = 3;
    Canvas.SetDrawColor(0,255,0);
    Canvas.DrawText("Hello World");
}

defaultproperties {
    bVisible= true
    bActive= true
}

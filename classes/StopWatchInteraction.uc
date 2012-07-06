class StopWatchInteraction extends Interaction;

function bool KeyEvent(EInputKey Key, EInputAction Action, float Delta ) {
	if (Action == IST_Press && Key == IK_PageDown)
		ViewportOwner.Actor.ClientMessage("Key PRESSED:" @ Key);
 
	return false;
}

defaultproperties {
    bActive= true
}

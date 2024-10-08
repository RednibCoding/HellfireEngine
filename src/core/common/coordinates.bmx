' Functions for world to screen coordinate transformation
Function WorldToScreenX:Int (x:Int, y:Int, tileWidth:Int)
    Return (x - y) * tileWidth / 2
EndFunction

Function WorldToScreenY:Int (x:Int, y:Int, tileHeight:Int)
    Return (x + y) * tileHeight / 2
EndFunction

' Functions for screen to world coordinate transformation
Function ScreenToWorldX:Int(screenX:Int, screenY:Int, tileWidth:Int, tileHeight:Int)
    ' Adjust the origin of a tile from top left to the center for calculations
    screenX = screenX + tileWidth / 2
    screenY = screenY + tileHeight / 2
    Local x:Float = (Float(screenX) / (tileWidth / 2) + Float(screenY) / (tileHeight / 2)) / 2.0
    Return Int(Floor(x))
EndFunction

Function ScreenToWorldY:Int(screenX:Int, screenY:Int, tileWidth:Int, tileHeight:Int)
    ' Adjust the origin of a tile from top left to the center for calculations
    screenX = screenX + tileWidth / 2
    screenY = screenY + tileHeight / 2
    Local y:Float = (Float(screenY) / (tileHeight / 2) - Float(screenX) / (tileWidth / 2)) / 2.0
    Return Int(Floor(y))
EndFunction

Function AdjustedScreenX(screenX:Int, tileWidth:Int)
	Local adjustedX:Int = screenX - tileWidth
	Return adjustedX
EndFunction

Function AdjustedScreenY(screenY:Int, tileHeight:Int, heightOffset:Int = 0)
    ' heightOffset can be used to shift the y-position up or down. Usefull when the actual
    ' tile height is bigger than the tile ground height.
	Local adjustedY:Int = screenY - tileHeight / 2
    Return adjustedY - heightOffset
EndFunction
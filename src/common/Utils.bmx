
Function ClampInt(value:Int Var, minValue:Int, maxValue:Int)
	If value < minValue Then value = minValue
	If value > maxValue Then value = maxValue
EndFunction

Function AngleBetweenPoints:Int(x1:Int, y1:Int, x2:Int, y2:Int)
	Local ang:Float = (-ATan2(x1 - x2, y1 - y2))
	If ang < 0 ang :+ 360
	If ang >= 360 ang :- 360
	Return ang
EndFunction

Function DistanceBetweenPoints:Float(x1:Int, y1:Int, x2:Int, y2:Int)
	Return Sqr((x1 - x2)^2 + (y1 - y2)^2)
EndFunction

Function IsPointWithinBounds:Int(pointX:Int, pointY:Int, boundX:Int, boundY:Int, boundWidth:Int, boundHeight:Int)
	If pointX >= boundX And pointX <= boundX + boundWidth
		If pointY >= boundY And pointY <= boundY + boundHeight
			Return True
		EndIf
	EndIf
	Return False
EndFunction

Function ScreenX:Float(worldX:Int, worldY:Int, tileW:Int)
	Return ( worldX * (tileW/2) ) - ( worldY * (tileW/2) )
EndFunction

Function ScreenY:Float(worldX:Int, worldY:Int, tileH:Int)
	Return ( worldX * (tileH/2) ) + ( worldY * (tileH/2) )
EndFunction

Function WorldX:Int(screenX:Float, screenY:Float, tileW:Int, tileH:Int)
	Return ( screenX / (tileW/2) + screenY / (tileH/2) ) / 2
EndFunction

Function WorldY:Int(screenX:Float, screenY:Float, tileW:Int, tileH:Int)
	Return ( screenY / (tileH/2) - screenX / (tileW/2) ) / 2
EndFunction

' Given an angle between 0 and 360 degrees
' it will return the corresponding cardinal point (North, north-east, east etc.)
Function AngleToDirection:EDirection(angle:Float)
	' View Up
	If (angle < 22.5 And angle >= 0) Or (angle < 360 And angle > 337.5) Then Return EDirection.N
	' View UpRight
	If angle >= 22.5 And angle < 67.5 Then Return EDirection.NE
	' View Right
	If angle >= 67.5 And angle < 112.5 Then Return EDirection.E
	' View DownRight
	If angle >= 112.5 And angle < 157.5 Then Return EDirection.SE
	' View Down
	If angle >= 157.5 And angle < 202.5 Then Return EDirection.S
	' View DownLeft
	If angle >= 202.5 And angle < 247.5 Then Return EDirection.SW
	' View Left
	If angle >= 247.5 And angle < 292.5 Then Return EDirection.W
	' View UpLeft
	If angle >= 292.5 And angle <= 337.5 Then Return EDirection.NW
EndFunction

Function DirectionToAngle:Float(direction:EDirection)
	Select direction
		Case EDirection.N
			Return 0.0
		Case EDirection.NE
			Return 45.0
		Case EDirection.E
			Return 90.0
		Case EDirection.SE
			Return 135.0
		Case EDirection.S
			Return 180.0
		Case EDirection.SW
			Return 225.0
		Case EDirection.W
			Return 270.0
		Case EDirection.NW
			Return 315.0
	EndSelect
EndFunction
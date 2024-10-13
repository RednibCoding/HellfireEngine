

Type TShape
	Field _x:Int, _y:Int
	Field _width:Int, _height:Int
	
	Method X:Int()
		Return _x
	EndMethod
	
	Method Y:Int()
		Return _y
	EndMethod
	
	Method Width:Int()
		Return _width
	EndMethod
	
	Method Height:Int()
		Return _height
	EndMethod
	
	Method SetPosition(x:Int, y:Int)
		_x = x
		_y = y
	EndMethod
	
	Method SetSize(width:Int, height:Int)
		_width = width
		_height = height
	EndMethod
	
	Method IsPointWithinBounds:Int(pointX:Int, pointY:Int)
		Return IsPointWithinBounds(pointX, pointY, _x, _y, _width, _height)
	EndMethod
EndType

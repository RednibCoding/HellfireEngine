

Type TIntMap Extends TShape
	Field _value:Int[,]
	
	Rem
	bbdoc: Sets resolution of the map.
	End Rem
	Method SetResolution(width:Int, height:Int)
		Local newValue:Int[,] = New Int[width, height]
		
		If _value Then
			For Local y:Int = 0 Until Min(_height, height )
				For Local x:Int = 0 Until Min(_width, width )
					newValue[x, y] = _value[x, y]
				Next
			Next
		EndIf
		
		_width = width
		_height = height
		_value = newValue
	End Method
	
	Method ValueAt:Int(xIndex:Int, yIndex:Int)
		Return _value[xIndex, yIndex]
	EndMethod
	
	Method SetValueAt(xIndex:Int, yIndex:Int, newValue:Int)
		_value[xIndex, yIndex] = newValue
	EndMethod
EndType
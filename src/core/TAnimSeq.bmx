
Type TAnimSeq
	Field _timer:Int
	Field _ms:Int
	
	Field _totalFrames:Int
	Field _currentFrame:Int
	Field _startFrame:Int
	Field _endFrame:Int
	Field _delay:Int
	
	Method New(startFrame:Int, endFrame:Int, delay_:Int)
		_totalFrames = endframe - startFrame
		_startFrame = startFrame
		_endFrame = endFrame
		_currentFrame = _startFrame
		_delay = delay_
	EndMethod
	
	Method NextFrame:Int()
		_ms = MilliSecs()
		If _currentFrame < _endFrame
			If _timer + _delay < _ms
				_currentFrame :+ 1
				_timer = _ms
			EndIf
			Return _currentFrame
		Else
			_currentFrame = _startFrame
			Return _currentFrame
		EndIf
	EndMethod
	
	Method SetDelay(delay_:Int)
		_delay = delay_
	EndMethod
EndType

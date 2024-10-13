Type TFps
	Field _old:Int
	Field _fps:Int
	
	Field _count:Int
	Field _time:Int
	
	Field _timer:TTimer
	
	Method New()
		_timer = CreateTimer(1)
	EndMethod
	
	Method Reset()
		_time = 0
		_count = 0
		_fps = 0
		_old = 0
	EndMethod
	
	Method Update()
		_count = _count + 1
		_time = TimerTicks(_timer) Mod 2
		If _time <> _old
			_fps = _count
			_count = 0
			_old = _time
		EndIf
	EndMethod
	
	Method Get:Int()
		Return _fps
	EndMethod
EndType

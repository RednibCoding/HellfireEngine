Type TFps
	Field fps:Int
	Field _old:Int
	Field _count:Int
	Field _time:Int
	Field _timer:TTimer
 
	Method New()
		self._timer = CreateTimer(1)
	EndMethod

	Method Reset()
		 Self._time = 0
		 Self._count = 0
		 Self.fps = 0
		 Self._old = 0
	EndMethod

	Method Update()
			Self._count = Self._count + 1
			Self._time = TimerTicks(Self._timer) Mod 2
		   If Self._time <> Self._old Then
			  Self.fps = Self._count
			  Self._count = 0
			  Self._old = Self._time
		   EndIf
	EndMethod 
 EndType
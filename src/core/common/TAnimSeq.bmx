Type TAnimSeq
	Field isPlaying:Int
	Field speed:Int

	Field _timer:Int
	Field _ms:Int
	Field _totalFrames:Int
	Field _currentFrame:Int
	Field _startFrame:Int
	Field _endFrame:Int

	Function Create:TAnimSeq(startFrame:Int, endFrame:Int, animSpeed:Int)
		Local this:TAnimSeq = New TAnimSeq
		this._totalFrames = endFrame - startFrame
		this._currentFrame = Rand(startFrame, endFrame)
		this._startFrame = startFrame
		this._endFrame = endFrame
		this.speed = animSpeed
		this.isPlaying = True

		Return this
	EndFunction

	Method Play(image:TImage, x:Int, y:Int)
		If Self._currentFrame < Self._endFrame Then
			If Not self.isPlaying
				DrawImage(image, x, y, Self._currentFrame)
				Return
			EndIf
			Self._ms = MilliSecs()
			If Self._timer + Self.speed < Self._ms Then
				Self._currentFrame = Self._currentFrame + 1
				If Self._currentFrame >= Self._endFrame Then Self._currentFrame = Self._startFrame
				Self._timer = Self._ms
			EndIf
			DrawImage(image, x, y, Self._currentFrame)
		EndIf		
	EndMethod
EndType 
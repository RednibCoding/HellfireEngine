
Type TAnimatedSprite Extends TShape
	Field _tileSets:TMap
	Field _animSeqs:TMap
	' Field _currentAnimation:String
	Field _velocity:Float = 2
	Field _facingAngle:Float = 0.0
	Field _direction:EDirection = EDirection.N

	Field _idleAnimations:TAnimSeq[8]
	Field _idleTilesets:TTileSet[8]	
	Field _runAnimations:TAnimSeq[8]
	Field _runTilesets:TTileSet[8]	
	Field _attackAnimations:TAnimSeq[8]
	Field _attackTilesets:TTileSet[8]
	Field _castAnimations:TAnimSeq[8]
	Field _castTilesets:TTileSet[8]	
	Field _dieTilesets:TAnimSeq[8]	
	Field _deathTilesets:TTileSet[8]

	Field _currentAnimation:EAnimation = EAnimation.IDLE

	Method AddAnimation(animDir:EDirection, tileset:TTileSet, animSeq:TAnimSeq)
		_idleTilesets[animDir] = tileset
		_idleAnimations[animDir] = animSeq
	EndMethod

	Method SetAnimation(animation:EAnimation)
		_currentAnimation = animation
	EndMethod

	Method SetDirection(dir:EDirection)
		_direction = dir
		_facingAngle = DirectionToAngle(dir)
	EndMethod
	
	Method RotateAroundPoint(pointX:Int, pointY:Int)
		Local angle:Float = AngleBetweenPoints(_x, _y, pointX, pointY)
		_facingAngle = angle
		_direction = AngleToDirection(_facingAngle)
		Local nextX:Int = _x + Cos(angle) * _velocity
		Local nextY:Int = _y + Sin(angle) * _velocity
		SetPosition(nextX, nextY)
	End Method
	
	Method MoveTowardsPoint(pointX:Int, pointY:Int)
		Local angle:Float = AngleBetweenPoints(_x, _y, pointX, pointY)
		_facingAngle = angle
		_direction = AngleToDirection(_facingAngle)
		Local nextX:Int = _x + Sin(angle) * _velocity
		Local nextY:Int = _y - Cos(angle) * _velocity
		SetPosition(nextX, nextY)
	End Method

	Method FacesPoint:Int(x:Int, y:Int, toleranceDeg:Int = 20)
		Local angleToPoint:Float = AngleBetweenPoints(_x, _y, x, y)
	
		If Abs(_facingAngle - angleToPoint) <= toleranceDeg Then
			Return True
		EndIf

		Return False
	End Method
	
	Method Draw()
		Local frame:Int = 0
		Local animSeq:TAnimSeq
		Local tileset:TTileSet
		Select _currentAnimation
			Case EAnimation.IDLE
				animSeq = _idleAnimations[_direction]
				tileset = _idleTilesets[_direction]
				frame = animSeq.NextFrame()
			Case EAnimation.RUN
				animSeq = _runAnimations[_direction]
				tileset = _runTilesets[_direction]
				frame = animSeq.NextFrame()
		EndSelect
		tileSet.Draw(_x, _y, frame)
	EndMethod
	
	Method SetVelocity(vel:Float)
		_velocity = vel
	EndMethod
	
	Method Velocity:Float()
		Return _velocity
	EndMethod
	
	' Overriding SetSize as changing width and height wouldn't make any sense here!
	' See: TShape.SetSize()
	Method SetSize(width:Int, height:Int)
		' Do nothing!
	EndMethod
EndType

SuperStrict

Include "src/HellfireEngine.bmx"

InitGraphics(1024, 700)
Local timer:TTimer = CreateTimer(60)


' Load Tilemap and the tilesets
Local gridTileset:TTileset = New TTileSet("assets/grid.png", 1, 128, 256, 64)
Local testTileset:TTileSet = New TTileSet("assets/tileset.png", 10, 128, 256, 64)

Local grid:TTileMap = New TTileMap(gridTileset, 10, 10)
Local drawGrid:Int = True

Local groundLayer:TTileMap = New TTileMap(testTileset, 10, 10)
groundLayer.FloodFill(1)

Local midlayer:TTileMap = New TTileMap(testTileset, 10, 10)

Local mat:Int = 0

groundLayer.SetPosition(groundLayer.Width()*(groundLayer.TileWidth()/2), 0)
midlayer.SetPosition(midlayer.Width()*(midlayer.TileWidth()/2), 0)
grid.SetPosition(grid.Width()*(grid.TileWidth()/2), 0)

' Load character and create animation sequences
Local necroIdle:TTileSet = New TTileSet("assets/necro/necro_idle.png", 64, 84, 108, 18)

Local necro_idle_s:TAnimSeq = New TAnimSeq(0, 7, 200)
Local necro_idle_sw:TAnimSeq = New TAnimSeq(8, 15, 200)
Local necro_idle_w:TAnimSeq = New TAnimSeq(16, 23, 200)
Local necro_idle_nw:TAnimSeq = New TAnimSeq(24, 31, 200)
Local necro_idle_n:TAnimSeq = New TAnimSeq(32, 39, 200)
Local necro_idle_ne:TAnimSeq = New TAnimSeq(40, 47, 200)
Local necro_idle_e:TAnimSeq = New TAnimSeq(48, 55, 200)
Local necro_idle_se:TAnimSeq = New TAnimSeq(56, 63, 200)

Local necro:TAnimatedSprite = New TAnimatedSprite()

necro.AddAnimation(EDirection.N, necroIdle, necro_idle_n)
necro.AddAnimation(EDirection.NE, necroIdle, necro_idle_ne)
necro.AddAnimation(EDirection.E, necroIdle, necro_idle_e)
necro.AddAnimation(EDirection.SE, necroIdle, necro_idle_se)
necro.AddAnimation(EDirection.S, necroIdle, necro_idle_s)
necro.AddAnimation(EDirection.SW, necroIdle, necro_idle_sw)
necro.AddAnimation(EDirection.W, necroIdle, necro_idle_w)
necro.AddAnimation(EDirection.NW, necroIdle, necro_idle_nw)

necro.SetAnimation(EAnimation.IDLE)
necro.SetDirection(EDirection.S)

midlayer.PlaceObject(necro, 3, 3)

While Not KeyDown(KEY_ESCAPE)
	If AppTerminate() Then End

	Local mx:Int = VirtualMouseX()
	Local my:Int = VirtualMouseY()
	Local mXs:Int = VirtualMouseXSpeed()
	Local mYs:Int = VirtualMouseYSpeed()
	Local mZs:Int = MouseZSpeed()
	
	mat = Abs((mat + mZs) Mod 10)
	
	Local tileX:Int = WorldX(mx-groundLayer.X(), my-groundLayer.Y(), groundLayer.TileWidth(), groundLayer.TilegroundHeight())
	Local tileY:Int = WorldY(mx-groundLayer.X(), my-groundLayer.Y(), groundLayer.TileWidth(), groundLayer.TilegroundHeight())

	ClampInt(tileX, 0, groundLayer.Width()-1)
	ClampInt(tileY, 0, groundLayer.Height()-1)
	
	If MouseDown(2)
		midlayer.SetTile(tileX, tileY, mat)
	EndIf
	If MouseDown(3)
		groundLayer.SetPosition(groundLayer.X()+mXs, groundLayer.Y()+mYs)
		midlayer.SetPosition(midlayer.X()+mXs, midlayer.Y()+mYs)
		grid.SetPosition(grid.X()+mXs, grid.Y()+mYs)
	EndIf
	
	If MouseDown(1)
		Local angle:Float = AngleBetweenPoints(necro.X(), necro.Y(), mx, my)
		Local dir:EDirection = AngleToDirection(angle)
	
		If DistanceBetweenPoints(necro.X(), necro.Y(), mx, my) > 10
			necro.MoveTowardsPoint(mx, my)
		EndIf
	EndIf

	
	If KeyHit(KEY_SPACE) Then drawGrid = 1 - drawGrid
	
	groundLayer.Draw()
	midlayer.Draw()
	If drawGrid Then grid.Draw()
	
	DrawText(tileX+ " " + tileY, 10, 10)
	DrawText(mat, 10, 20)
	DrawText(necro.FacesPoint(mx, my), 10, 30)

Flip;WaitTimer(timer);Cls;Wend;End


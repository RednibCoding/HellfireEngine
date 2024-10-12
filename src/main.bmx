Include "core/common/coordinates.bmx"
Include "core/map/TTileMap.bmx"
Include "core/common/TAnimSeq.bmx"
Include "core/common/TFps.bmx"


' Main game loop
Graphics(1280, 800, 0, 60, 2)
SetBlend(ALPHABLEND)
SetVirtualResolution(1024, 600)
AppTitle = "Hellfire Engine Demo"

' Initialize the tile map
Local map:TTileMap = New TTileMap(100, 100, 20, 20, TTile.TILE_WIDTH, TTile.TILE_HEIGHT)

Local tileset:TImage = LoadAnimImage("tmp/tileset.png", TTile.TILE_WIDTH, TTile.TILE_TOTAL_HEIGHT, 0, 5)
Global highlightImg:TImage = LoadImage("tmp/highlight.png")
Local tileIdToSet = 1

Local char:TImage = LoadAnimImage("tmp/character2.png", 96, 96, 0, 20);
Local charIdle:TAnimSeq = New TAnimSeq(0, 20, 100);
Local fpsCounter:TFps = New TFps()

While Not AppTerminate()
    fpsCounter.Update()
    Cls()
    
    ' Get mouse position
    Local mouseX:Int = VirtualMouseX()
    Local mouseY:Int = VirtualMouseY()
    Local mh1:Int = MouseHit(1)
    Local mh2:Int = MouseHit(2)
    Local md2:Int = MouseDown(2)
    Local mxs:Int = MouseXSpeed()
    Local mys:Int = MouseYSpeed()

    ' Convert mouse position to world coordinates
    Local worldX:Int = ScreenToWorldX(mouseX - map.x, mouseY - map.y, map.tileWidth, map.tileHeight)
    Local worldY:Int = ScreenToWorldY(mouseX - map.x, mouseY - map.y, map.tileWidth, map.tileHeight)

	map.Draw(tileset)

	map.HightlightTile(highlightImg, worldX, worldY)

    charIdle.Play(char, map.x + 100, map.y + 100)

    If mh1
        tileIdToSet = (tileIdToSet + 1) Mod 5
        map.SetTile(0, worldX, worldY, tileIdToSet)
    ElseIf mh2
        map.SetTile(0, worldX, worldY, 0)
    EndIf

    If md2
        map.Move(mxs, mys)
    EndIf

    ?Debug
        DrawText(fpsCounter.fps + " FPS", 10, 10)
        DrawText("worldX: " + worldX + " worldY: " + worldY, 10, 30)
    ?
    Flip(1)
Wend
Include "core/common/coordinates.bmx"
Include "core/map/TTileMap.bmx"


' Main game loop
Graphics(1280, 800, 0, 60, 2)

' Initialize the tile map
Local map:TTileMap = New TTileMap(100, 100, 20, 20, TTile.TILE_WIDTH, TTile.TILE_HEIGHT)

Local tileset:TImage = LoadAnimImage("tmp/tileset.png", TTile.TILE_WIDTH, TTile.TILE_TOTAL_HEIGHT, 0, 5)
Global highlightImg:TImage = LoadImage("tmp/highlight.png")
Local tileIdToSet = 1

While Not AppTerminate()
    Cls()
    
    ' Get mouse position
    Local mouseX:Int = MouseX()
    Local mouseY:Int = MouseY()
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

    If mh1
        tileIdToSet = (tileIdToSet + 1) Mod 5
        map.SetTile(0, worldX, worldY, tileIdToSet)
    ElseIf mh2
        map.SetTile(0, worldX, worldY, 0)
    EndIf

    If md2
        ' map.Move(mxs, mys)    
        map.Move(1, 0)  
    EndIf

    ?Debug
        DrawText("worldX: " + worldX + " worldY: " + worldY, 10, 10)
    ?
    
    Flip(1)
Wend
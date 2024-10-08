Type TTile
	Const TILE_WIDTH = 128
	Const TILE_HEIGHT = 64
	Const TILE_ADDITIONAL_HEIGHT = 128
	Const TILE_TOTAL_HEIGHT = TILE_HEIGHT + TILE_ADDITIONAL_HEIGHT

    Field tileID:Int ' The tile id in the tileset
    Field walkable:Int ' Determines if a tile is generally walkable (0 = not walkable, 1 = walkable) (this should never be changed once its set
	Field occupied:Int ' Determines if a tile is currently blocked/occupied (this can change depending wether an object is currently occupying the tile -> only one object per tile)

	Method Draw(tileset:TImage, screenX:Int, screenY:Int, tileID:Int = -1)
		' An optional tileID can be passed to draw a different tile at this
		' location instead of this actual tile
		Local tileIDToDraw = self.tileID
		If tileID > -1 Then tileIDToDraw = tileID

		If tileIDToDraw > -1
			DrawImage(tileset, screenX, screenY, tileIDToDraw)
		EndIf
	EndMethod
EndType
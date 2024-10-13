
Include "TIntMap.bmx"

Type TTileMap Extends TIntMap
	
	Rem
	bbdoc: Tilemap's Default tileset.
	about: See also: #TTileSet
	End Rem
	Field _tileSet:TTileSet
	
	Rem
	bbdoc: List of objects of Type TSprite Or TAnimatedSprite that will be depth sorted.
	about: See also: #AttachZSortedObjects
	End Rem
	Field _zSortedObjects:TList

	Rem
	bbdoc: Returns tilemap tile width.
	returns: Tile width of the tilemap in units.
	about: See also: #GetTileHeight
	End Rem
	Method TileWidth:Int()
		Return _tileSet.TileWidth()
	EndMethod
	
	Rem
	bbdoc: Returns tilemap tile height.
	returns: Tile width of the tilemap in units.
	about: See also: #GetTileWidth
	End Rem
	Method TileHeight:Int()
		Return _tileSet.TileHeight()
	EndMethod
	
	Rem
	bbdoc: Returns tile ground height.
	returns: Tile ground height of the tilemap in units.
	about: See also: #GetTileHeight
	End Rem
	Method TileGroundHeight:Int()
		Return _tileSet.TileGroundHeight()
	EndMethod
	
	Rem
	bbdoc: Returns tile index For given coordinates.
	returns: Tile index For given tile coordinates.
	about: See also: #SetTile
	End Rem
	Method GetTile:Int(tileX:Int, tileY:Int)
		Return ValueAt(tileX, tileY)
	EndMethod
	
	Rem
	bbdoc: Sets tile index For given tile coordinates.
	about: See also: #GetTile
	End Rem
	Method SetTile(tileX:Int, tileY:Int, tileNum:Int)
		SetValueAt(tileX, tileY, tileNum)
	EndMethod
	
	Method TileSet:TTileSet()
		Return _tileSet
	EndMethod
	
	Method FloodFill(tileNum:Int)
		For Local tileY:Int = 0 Until _height
			For Local tileX:Int = 0 Until _width
				SetTile(tileX, tileY, tileNum)
			Next
		Next
	EndMethod
	
	Method SetPosition(x:Int, y:Int)
		Local dX:Int = _x - x
		Local dy:Int = _y - y
		_x = x
		_y = y

		' Consider all objects as well
		For Local obj:TShape = EachIn _zSortedObjects
			obj.SetPosition(obj.X() - dx, obj.Y() - dy)
		Next
	EndMethod
	
	Method New(tileSet:TTileSet, width:Int, height:Int)
		SetResolution(width, height)
		_tileSet = tileSet
		_zSortedObjects = New TList
	EndMethod
	
	Rem
	bbdoc: Adds an Object To the tilemap that will be depth sorted.
	about: Type must be TSprite or TAnimatedSprite
	End Rem
	Method PlaceObject(obj:TShape, tileX:Int, tileY:Int)
		Local screenX:Int = ScreenX(tileX, tileY, TileWidth()) + _x
		Local screenY:Int = ScreenY(tileX, tileY, TileGroundHeight()) + _y
		obj.SetPosition(screenX, screenY)
		_zSortedObjects.AddLast(obj)
	EndMethod
	
	Rem
	bbdoc: Draws the tile map on the screen
	about: animatedSprites is a list of TAnimatedSprites that will also be drawn with depth sorting.
	End Rem
	Method Draw()
		Local posX:Int = 0
		Local posY:Int = 0
		' Needed For depth sorting of animatedSprites
		Local prevPosX:Int = 0
		Local nextPosX:Int = 0
		Local nextPosY:Int = 0
		
		Local material:Int = 0
		
		For Local tileY:Int = 0 Until _height
			For Local tileX:Int = 0 Until _width
			
				posX = ScreenX(tileX, tileY, TileWidth())
				posY = ScreenY(tileX, tileY, TileGroundHeight())

				material = GetTile(tileX, tileY)

				' Draw _zSortedObjects
				If Not _zSortedObjects.IsEmpty()
					' Needed For depth sorting of zSortedObjects
					prevPosX = ScreenX(tileX-1, tileY, TileWidth())
					nextPosX = ScreenX(tileX+1, tileY, TileWidth())
					nextPosY = ScreenY(tileX, tileY+1, TileHeight())
					
					For Local shape:TShape = EachIn _zSortedObjects
						If TSprite(shape)
							Local spriteObj:TSprite = TSprite(shape)
							If spriteObj.X() >= prevPosX + _x And spriteObj.X() <= nextPosX + _x
								If spriteObj.Y() >= posY + _y And spriteObj.Y() <= nextPosY + _y
									spriteObj.Draw()
								EndIf
							EndIf
						ElseIf TAnimatedSprite(shape)
							Local animatedSpriteObj:TAnimatedSprite = TAnimatedSprite(shape)
							If animatedSpriteObj.X() >= prevPosX + _x And animatedSpriteObj.X() <= nextPosX + _x
								If animatedSpriteObj.Y() >= posY + _y And animatedSpriteObj.Y() <= nextPosY + _y
									animatedSpriteObj.Draw()
								EndIf
							EndIf
						Else
							Error("Invalid objects set For z-sorting!" + Chr(13) + "Type must be TSprite Or TAnimatedSprite.")
						EndIf
					Next
				EndIf
				_tileSet.Draw(posX + _x, posY + _y, material)
			Next
		Next
	EndMethod

EndType







Rem
	bbdoc: Tileset Type.
	about: Each tile of a tileset has its origin at the top of the ground tile height
	about:    x
	about:   / \
	about:  /   \
	about: 	\   /
	about:   \ /
End Rem
Type TTileSet
	Field _image:TImage
	Field _tileWidth:Int
	Field _tileHeight:Int
	Field _tileGroundHeight:Int
	Field _tileCount:Int
	
	Method New(imagePath:String, tileCount:Int, tileWidth:Int, tileHeight:Int, tileGroundHeight:Int)
		_tileWidth = tileWidth
		_tileHeight = tileHeight
		_tileGroundHeight = tileGroundHeight
		_tileCount = tileCount
		_image = LoadAnimImage(imagePath, _tileWidth, _tileHeight, 0, _tileCount)
		If Not _image Then Error("Unable to load file: "+ imagePath + Chr(13) + "Make sure the image exists and that the tile sizes are correct!")
		SetImageHandle(_image, _tileWidth/2, _tileHeight - _tileGroundHeight)
	EndMethod
	
	Method Draw(x:Int, y:Int, frame:Int)
		DrawImage(_image, x, y, frame)
	EndMethod
	
	Rem
	bbdoc: Returns tile width.
	returns: Tile width of the tilemap in units.
	about: See also: #GetTileHeight
	End Rem
	Method TileWidth:Int()
		Return _tileWidth
	EndMethod
	
	Rem
	bbdoc: Returns tile height.
	returns: Tile height of the tilemap in units.
	about: See also: #GetTileWidth
	End Rem
	Method TileHeight:Int()
		Return _tileHeight
	EndMethod
	
	Rem
	bbdoc: Returns tile ground height.
	returns: Tile ground height of the tilemap in units.
	about: See also: #GetTileHeight
	End Rem
	Method TileGroundHeight:Int()
		Return _tileGroundHeight
	EndMethod
EndType
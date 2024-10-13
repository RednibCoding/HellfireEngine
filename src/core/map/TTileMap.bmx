Include "TTile.bmx"

Type TTileMap
    Field x:Int
    Field y:Int
    Field width:Int
    Field height:Int
    Field tileWidth:Int
    Field tileHeight:Int
    ' A tilemap has exactly 3 layers: ground, object and top
    Field layer0:TTile[,]
    Field layer1:TTile[,]
    Field layer2:TTile[,]

    Function Create:TTileMap(x:Int, y:Int, width:Int, height:Int, tileWidth:Int, tileHeight:Int)
        Local this:TTileMap = New TTileMap
        this.x = x
        this.y = y
        this.width = width
        this.height = height
        this.tileWidth = tileWidth
        this.tileHeight = tileHeight

        ' Initialize the map array
        this.layer0 = New TTile[this.width, this.height]
        For Local y:Int = 0 Until this.width
            For Local x:Int = 0 Until this.height
                this.layer0[x, y] = New TTile
                this.layer0[x, y].tileID = 0
                this.layer0[x, y].occupied = 0
            Next
        Next
        this.layer1 = New TTile[this.width, this.height]
        For Local y:Int = 0 Until this.width
            For Local x:Int = 0 Until this.height
                this.layer1[x, y] = New TTile
                this.layer1[x, y].tileID = -1
                this.layer1[x, y].occupied = 0
            Next
        Next
        this.layer2 = New TTile[this.width, this.height]
        For Local y:Int = 0 Until this.width
            For Local x:Int = 0 Until this.height
                this.layer2[x, y] = New TTile
                this.layer2[x, y].tileID = -1
                this.layer2[x, y].occupied = 0
            Next
        Next
        Return this
    EndFunction

    Method SetTile(layer:Int, worldX:Int, worldY:Int, tileID:Int)
        If worldX >= 0 And worldX < self.width And worldY >= 0 And worldY < self.height
            If layer = 0
                layer0[worldX, worldY].tileID = tileID
            ElseIf layer = 1
                layer1[worldX, worldY].tileID = tileID
            Else
                layer2[worldX, worldY].tileID = tileID
            EndIf
        EndIf
    EndMethod

    Method Move(x:int, y:int)
        self.x = self.x + x
        self.y = self.y + y
    EndMethod
    
    Method Draw(tileset:TImage)
        For Local y:Int = 0 Until self.height
            For Local x:Int = 0 Until self.width
                Local tile:TTile = layer0[x, y]
                self.drawTile(tile, tileset, x, y, TTile.TILE_ADDITIONAL_HEIGHT)
            Next
        Next 
    EndMethod

    Method HightlightTile(image:TImage, worldX:Int, worldY:Int)
        If worldX >= 0 And worldX < self.width And worldY >= 0 And worldY < self.height
            Local tileToHighlight:TTile = self.layer0[worldX, worldY]
            self.drawTile(tileToHighlight, image, worldX, worldY, 0, 0)
        EndIf
	EndMethod

    Method drawTile(tile:TTile, tileset:TImage, worldX:Int, worldY:Int, heightOffset:Int = 0, tileID:Int = -1)
        Local screenX:Int = WorldToScreenX(worldX, worldY, tileWidth)
        Local screenY:Int = WorldToScreenY(worldX, worldY, tileHeight)

        ' Adjust for tile image offset
        Local adjustedScreenX:Int = AdjustedScreenX(screenX, tileWidth)
        Local adjustedScreenY:Int = AdjustedScreenY(screenY, tileHeight, heightOffset)

        tile.Draw(tileset, adjustedScreenX + self.x, adjustedScreenY + self.y, tileID)
    EndMethod
EndType
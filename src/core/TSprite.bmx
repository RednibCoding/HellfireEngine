
Type TSprite Extends TShape
	Field _image:TImage
	
	Method New(imagePath:String, originX:Int, originY:Int)
		_image = LoadImage(imagePath)
		_width = ImageWidth(_image)
		_height = ImageHeight(_image)
		_x = 0
		_y = 0
		SetImageHandle(_image, originX, originY)
	EndMethod
	
	Method Draw()
		DrawImage(_image, _x, _y)
	EndMethod
	
	' Overriding SetSize to make sure the sprite size does not get changed!
	' The Sprite size should not be changed as the width and height
	' comes from the image size and is fixed!
	' See: TShape.SetSize()
	Method SetSize(width:Int, height:Int)
		' Do nothing!
	EndMethod
EndType

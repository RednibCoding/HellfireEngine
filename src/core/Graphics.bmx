

Rem
bbdoc: Sets graphics mode.
about: Provide width And height of screen in pixels.
End Rem
Function InitGraphics(width:Int, height:Int)
	Graphics( width, height )
	SetVirtualResolution( width, height )
	AutoImageFlags( FILTEREDIMAGE | DYNAMICIMAGE )
	SetBlend( AlphaBlend )
End Function
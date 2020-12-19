Class {
	#name : #SpriteLoader,
	#superclass : #Morph,
	#instVars : [
		'imageContainer',
		'height',
		'spriteWidth',
		'spriteHeight',
		'spiteSheet',
		'spriteSheet',
		'spriteProperties'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
SpriteLoader >> addImage: image toContainer: container [
	| scrollPane |
	scrollPane := BlPannableElement new.
	self
		imageContainer:
			(BlElement new
				background: image;
				size: image width @ image height;
				margin: (BlInsets all: 10)).	"BlScrollableElement new
		background: Color white;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]."
	"scrollPane addChild: self imageContainer."
	scrollPane
		contentElement: self imageContainer;
			in: [ :aPannable | aPannable zoomableElement clipChildren: false ];
		zoomToActualSize.
	container addChild: scrollPane
]

{ #category : #accessing }
SpriteLoader >> imageContainer [
	^ imageContainer
]

{ #category : #accessing }
SpriteLoader >> imageContainer: anObject [
	imageContainer := anObject.
	self tesselateSpriteSheet
]

{ #category : #accessing }
SpriteLoader >> initialize [
	spriteHeight := 128.
	spriteWidth := 128.
	spriteProperties := SpriteProperties new model: self
]

{ #category : #accessing }
SpriteLoader >> loadPNG: aView [
	<gtView>
	| file browser |
	^ aView explicit
		title: 'Details' translated;
		priority: 5;
		stencil: [ | container |
			container := BlElement new
				layout: BlLinearLayout vertical;
				background: Color white;
				addLook: BrShadowLook;
				margin: (BlInsets all: 20);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ].
			browser := BrFileSelector new.
			browser
				hMatchParent;
				vMatchParent;
				buttonLabel: 'Import';
				okAction: [ :filepath | 
					| image |
					image := PNGReadWriter formFromFileNamed: filepath.
					spriteSheet := image.
					self addImage: image toContainer: container ].
			container addChild: browser.
			container addChild: spriteProperties.
			container ]
]

{ #category : #accessing }
SpriteLoader >> spriteActionsCard [
	<gtExample>
	| anElement aButtonElement aPictureElement aDescriptionElement aButtonElement2 |
	anElement := BrHorizontalPane new.
	anElement
		addLook: BrShadowLook;
		margin: (BlInsets all: 10);
		padding: (BlInsets all: 10);
		fitContent;
		cellSpacing: 10;
		background: Color white.
	aButtonElement := BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Default';
		action: [ :aButton | 'Clicked foo' traceCr ].
	aButtonElement2 := BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Foobar';
		action: [ :aButton | 'Clicked bar' traceCr ].
	anElement addChild: aButtonElement.
	anElement addChild: aButtonElement2.
	^ anElement
]

{ #category : #accessing }
SpriteLoader >> spriteHeight [
	^spriteHeight
]

{ #category : #accessing }
SpriteLoader >> spriteHeight: h [
	spriteHeight := h
]

{ #category : #accessing }
SpriteLoader >> spriteWidth [
	^spriteWidth
]

{ #category : #accessing }
SpriteLoader >> spriteWidth: w [
	spriteWidth := w
]

{ #category : #accessing }
SpriteLoader >> tesselateSpriteSheet [
	| heightSteps widthSteps pos |
	heightSteps := (spriteSheet height / spriteHeight) asInteger.
	widthSteps := (spriteSheet width / spriteWidth) asInteger.
	Transcript
		show:
			'tesselateSpriteSheet.. heightSteps = ' , heightSteps asString
				, ' widthSteps = ' , widthSteps asString;
		cr.
	0 to: heightSteps do: [ :y | 
		| yline |
		yline := self tesselationLine.
		yline
			fromAnchor: (BlAbsolutePositionAnchor new position: 0 @ (y * spriteHeight));
			toAnchor:
				(BlAbsolutePositionAnchor new
					position: spriteSheet width @ (y * spriteHeight)).
		imageContainer addChild: yline ].
	0 to: widthSteps do: [ :x | 
		| xline |
		xline := self tesselationLine.
		xline
			fromAnchor: (BlAbsolutePositionAnchor new position: (x * spriteWidth) @ 0);
			toAnchor:
				(BlAbsolutePositionAnchor new
					position: (x * spriteWidth) @ spriteSheet height).
		imageContainer addChild: xline ]
]

{ #category : #accessing }
SpriteLoader >> tesselationLine [
	^ BlLineElement new
		zIndex: 10;border: (BlBorder paint: Color gray width: 1);
		yourself
]

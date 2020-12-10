Class {
	#name : #SpriteLoader,
	#superclass : #Morph,
	#instVars : [
		'imageContainer',
		'height',
		'spriteWidth',
		'spriteHeight'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
SpriteLoader >> addImage: image toContainer: container [
	| b |
	b := BlBounds new
		top: 0;
		left: 0;
		bottom: image height;
		right: image width.
	self
		imageContainer:
			(BlElement new
				geometryBounds: b;
				background: image;
				margin: (BlInsets all: 10)).
	container addChild: self imageContainer
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
]

{ #category : #accessing }
SpriteLoader >> loadPNG [
	| file |
	file := UIManager default
		chooseFullFileNameMatching: #('png')
		label: 'Import Spritesheet.'.
	^ file
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
					c horizontal fitContent.
					c vertical fitContent ].
			browser := BrFileSelector new.
			browser
				hMatchParent;
				vMatchParent;
				buttonLabel: 'Import';
				okAction: [ :filepath | 
					| image |
					Transcript
						show: 'Loading image ' , filepath asString;
						cr.
					image := PNGReadWriter formFromFileNamed: filepath.
					self addImage: image toContainer: container ].
			container addChild: browser.
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
SpriteLoader >> tesselateSpriteSheet [
	| heightSteps |
	
	heightSteps := (imageContainer height / spriteHeight) asInteger.
	Transcript
		show: 'tesselateSpriteSheet.. heightSteps = ',heightSteps asString,' imgctr bounds = ',imageContainer bounds asString;
		cr.
	0 to: heightSteps do: [ :y | 
		| yline pos |
		yline := self tesselationLine.
		pos := imageContainer size x @ imageContainer size y  .
		yline
			fromAnchor:
				(BlAbsolutePositionAnchor new position: (y * spriteHeight) @ pos x);
			toAnchor:
				(BlAbsolutePositionAnchor new
					position: (y * spriteHeight) @ (pos x + imageContainer width)).
		imageContainer addChild: yline ]
]

{ #category : #accessing }
SpriteLoader >> tesselationLine [
	^ BlLineElement new
		zIndex: 10;border: (BlBorder paint: Color gray width: 1);
		yourself
]

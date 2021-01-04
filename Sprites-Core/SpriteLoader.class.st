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
		'spriteProperties',
		'container',
		'startFrame',
		'endFrame',
		'announcer',
		'startPos',
		'endPos',
		'selectedSprite',
		'currentSprite',
		'sprites'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
SpriteLoader >> addImage: image toContainer: c [
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
	c addChild: scrollPane
]

{ #category : #accessing }
SpriteLoader >> addImageButtonsToSpriteSheet [
	| heightSteps widthSteps sheet |
	sheet := spriteSheet sheet.
	heightSteps := (sheet height / spriteHeight) asInteger.
	widthSteps := (sheet width / spriteWidth) asInteger.
	0 to: heightSteps do: [ :y | 
		0 to: widthSteps do: [ :x | 
			imageContainer
				addChild:
					(self spriteSelectButtonAt: (x * spriteWidth) @ (y * spriteHeight)) ] ]
]

{ #category : #accessing }
SpriteLoader >> announcer [
  ^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
SpriteLoader >> createContainer [
	^ BlElement new
				layout: BlLinearLayout vertical;
				background: Color white;
				addLook: BrShadowLook;
				margin: (BlInsets all: 20);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ]
]

{ #category : #accessing }
SpriteLoader >> createLineFrom: from to: to [
	| line |
	line := self tesselationLine.
	line
		fromAnchor: (BlAbsolutePositionAnchor new position: from);
		toAnchor: (BlAbsolutePositionAnchor new position: to).
	^ line
]

{ #category : #accessing }
SpriteLoader >> createSpriteList [
	^ BrSimpleList new
		itemStencil: [
			BrLabel new
				"hMatchParent;"
				look: BrGlamorousLabelLook new + (BrStyleCommonLook new
					selected: [ :aStyle | aStyle background: Color veryVeryLightGray ]);
				padding: (BlInsets all: 5) ];
		itemDataBinder: [ :eachElement :eachClass :eachIndex | eachElement text: eachClass name ];
		items: self sprites 
]

{ #category : #accessing }
SpriteLoader >> currentSprite [
	^currentSprite
]

{ #category : #accessing }
SpriteLoader >> currentSprite: aSprite [
	currentSprite := aSprite
]

{ #category : #accessing }
SpriteLoader >> endFrame: e [
	endFrame := e
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
	spriteProperties := SpriteAnimationProperties new model: self.
	currentSprite := AnimatedSprite new.
	sprites := OrderedCollection new.
	sprites add currentSprite
	
]

{ #category : #accessing }
SpriteLoader >> loadPNG: aView [
	<gtView>
	| file browser |
	^ aView explicit
		title: 'Details' translated;
		priority: 5;
		stencil: [ container := self createContainer .
			self recreateView.
			container ]
]

{ #category : #accessing }
SpriteLoader >> newAnimation [
]

{ #category : #accessing }
SpriteLoader >> recreateView [
	| browser |
	container removeChildren.
	browser := BrFileSelector new.
	container addChild: browser.
	container addChild: spriteProperties.
	browser
		hMatchParent;
		vMatchParent;
		buttonLabel: 'Import';
		okAction: [ :filepath | 
			| image |
			image := PNGReadWriter formFromFileNamed: filepath.
			spriteSheet := SpriteSheet new sheet: image.
			self recreateView ].
	spriteSheet
		ifNotNil: [ self addImage: spriteSheet sheet toContainer: container ]
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
	spriteHeight := h.
]

{ #category : #accessing }
SpriteLoader >> spriteSelectButtonAt: pos [
	^ BlElement new
		relocate: pos;
		when: BlClickEvent
			do: [ :event | self spriteSelectButtonClicked: pos ];
		size: spriteWidth @ spriteHeight;
		background: (Color gray alpha: 0.3)
]

{ #category : #accessing }
SpriteLoader >> spriteSelectButtonClicked: pos [
	| form |
	Transcript
		show: 'button ' , pos asString , ' clicked';
		cr.
	form := spriteSheet sheet
		copy: (pos corner:  (spriteWidth @ spriteHeight)).
	self announcer
		announce:
			(SpriteSelectedAnnouncement new
				form: form;
				pos: pos)
]

{ #category : #accessing }
SpriteLoader >> spriteWidth [
	^spriteWidth
]

{ #category : #accessing }
SpriteLoader >> spriteWidth: w [
	spriteWidth := w.
]

{ #category : #accessing }
SpriteLoader >> sprites [
	^ sprites
]

{ #category : #accessing }
SpriteLoader >> tesselateSpriteSheet [
	| heightSteps widthSteps pos sheet |
	sheet := spriteSheet sheet.
	heightSteps := (sheet height / spriteHeight) asInteger.
	widthSteps := (sheet width / spriteWidth) asInteger.
	0 to: heightSteps do: [ :y | 
		imageContainer
			addChild:
				(self
					createLineFrom: 0 @ (y * spriteHeight)
					to: sheet width @ (y * spriteHeight)) ].
	0 to: widthSteps do: [ :x | 
		imageContainer
			addChild:
				(self
					createLineFrom: (x * spriteWidth) @ 0
					to: (x * spriteWidth) @ sheet height) ].
	self addImageButtonsToSpriteSheet
]

{ #category : #accessing }
SpriteLoader >> tesselationLine [
	^ BlLineElement new
		zIndex: 10;border: (BlBorder paint: Color gray width: 1);
		yourself
]

Class {
	#name : #SpriteAnimationProperties,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'model',
		'startPos',
		'endPos',
		'animationName'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
SpriteAnimationProperties >> animationButtons [
	| nameLabel nameEditor startButton endButton element infoLabel |
	nameLabel := BrLabel new
		text: 'Animation name:';
		look: BrGlamorousLabelLook new.
	nameEditor := BrEditor new
		size: 300 @ 100;
		text: 'animation1';
		look: BrGlamorousRegularEditorLook new.
	nameEditor editor
		when: BrTextEditorModifiedEvent
		do: [ :e | 
			Transcript
				show: 'animation name changed to ',e text;
				cr.
				animationName := e text ].
	infoLabel := BrLabel new
		text: 'Click start and end animation frames';
		look: BrGlamorousLabelLook new.
	element := BrHorizontalPane new.
	element
		fitContent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	element
		addChild: nameLabel;
		addChild: nameEditor;
		"addChild: startButton;
		addChild: endButton."
			addChild: infoLabel.
	^ element
]

{ #category : #accessing }
SpriteAnimationProperties >> createAnimation: name startFrame: s endFrame: e [
	^ (model spriteSheet) getSpritesFrom: s to: e
]

{ #category : #accessing }
SpriteAnimationProperties >> glamorousLabel [
	| aLabel |
	aLabel := BrLabel new.
	aLabel look: BrGlamorousLabelLook new.
	aLabel forceLayout.
	^ aLabel
]

{ #category : #accessing }
SpriteAnimationProperties >> initialize [
	super initialize.
	self
		addLook: BrShadowLook;
		margin: (BlInsets all: 10);
		padding: (BlInsets all: 10);
		fitContent;
		cellSpacing: 10;
		background: Color white.
		
		
]

{ #category : #accessing }
SpriteAnimationProperties >> model: aModel [
	model := aModel.
	self addChild: self spriteTesselation.
	self addChild: self animationButtons.
	model announcer when: SpriteSelectedAnnouncement do: [:e | self spriteSelected: e].
]

{ #category : #accessing }
SpriteAnimationProperties >> spriteSelected: e [
	Transcript
		show: 'sprite selected: ' , e pos asString;
		cr.
	startPos
		ifNil: [ startPos := e pos ]
		ifNotNil: [ endPos := e pos.
			model currentSprite
				addAnimation:
					(self
						createAnimation: animationName
						startFrame: startPos
						endFrame: endPos) named: animationName.
			model announcer
				announce: (AnimatedSpriteSelected new animatedSprite: model currentSprite) ]
]

{ #category : #accessing }
SpriteAnimationProperties >> spriteTesselation [
	| element aButtonElement xValueEditor yValueEditor xLabel yLabel |
	element := BrHorizontalPane new.
	element
		fitContent;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	xLabel := BrLabel new
		text: 'Sprite Width:';
		look: BrGlamorousLabelLook new.
	yLabel := BrLabel new
		text: 'Sprite Height:';
		look: BrGlamorousLabelLook new.
	xValueEditor := BrEditor new
		text: model spriteWidth;
		look: BrGlamorousRegularEditorLook new.
	yValueEditor := BrEditor new
		text: model spriteHeight;
		look: BrGlamorousRegularEditorLook new.
	aButtonElement := BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Save';
		action: [ :aButton | 
			| x y |
			x := xValueEditor text asString asInteger.
			y := yValueEditor text asString asInteger.
			model
				spriteHeight: y;
				spriteWidth: x;
				recreateView ].
	element
		addChild: xLabel;
		addChild: xValueEditor;
		addChild: yLabel;
		addChild: yValueEditor.
	element addChild: aButtonElement.
	^ element
]

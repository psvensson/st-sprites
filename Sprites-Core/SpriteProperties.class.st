Class {
	#name : #SpriteProperties,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'model'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
SpriteProperties >> glamorousLabel [
	| aLabel |
	aLabel := BrLabel new.
	aLabel look: BrGlamorousLabelLook new.
	aLabel forceLayout.
	^ aLabel
]

{ #category : #accessing }
SpriteProperties >> initialize [
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
SpriteProperties >> model: aModel [
	model := aModel.
	self addChild: self spriteTesselation
]

{ #category : #accessing }
SpriteProperties >> spriteTesselation [
	| element aButtonElement xValueEditor yValueEditor |
	element := BlElement new.
	
	xValueEditor := BrEditor new text: model spriteWidth.
	yValueEditor := BrEditor new text: model spriteHeight.
	
	aButtonElement := BrButton new
		look: BrGlamorousButtonWithLabelLook new;
		label: 'Default';
		action: [ :aButton | 'Clicked foo' traceCr ].
	element addChild: aButtonElement.
	^ element
]

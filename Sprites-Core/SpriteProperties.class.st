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

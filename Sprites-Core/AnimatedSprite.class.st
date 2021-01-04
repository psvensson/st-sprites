Class {
	#name : #AnimatedSprite,
	#superclass : #Sprite,
	#instVars : [
		'animations'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
AnimatedSprite >> addAnimation: a named: animationName [
	animations at: animationName put: a
]

{ #category : #accessing }
AnimatedSprite >> animations [
	^animations
]

{ #category : #accessing }
AnimatedSprite >> initialize [
	super initialize.
	animations := Dictionary new.
]

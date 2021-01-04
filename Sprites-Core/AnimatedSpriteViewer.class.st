Class {
	#name : #AnimatedSpriteViewer,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'animatedSprite',
		'model'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
AnimatedSpriteViewer >> animatedSprite: a [
	animatedSprite := a
]

{ #category : #accessing }
AnimatedSpriteViewer >> initialize [
	super initalize.
	
]

{ #category : #accessing }
AnimatedSpriteViewer >> model: m [
	model := m
]

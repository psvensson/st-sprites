Class {
	#name : #AnimatedSpriteSelected,
	#superclass : #Announcement,
	#instVars : [
		'animatedSprite'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
AnimatedSpriteSelected >> animatedSprite [
	^animatedSprite
]

{ #category : #accessing }
AnimatedSpriteSelected >> animatedSprite: a [
	animatedSprite := a.
]

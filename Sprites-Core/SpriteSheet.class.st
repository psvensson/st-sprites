Class {
	#name : #SpriteSheet,
	#superclass : #Object,
	#instVars : [
		'sheet',
		'spriteWidth',
		'spriteHeight'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
SpriteSheet >> getSpriteAt: pos [
	^ sheet copy: (pos corner: spriteWidth @ spriteHeight)
]

{ #category : #accessing }
SpriteSheet >> getSpritesFrom: start to: end [
	| rv |
	rv := OrderedCollection new.
	start y to end y
		do: [ :y | start x to: end x do: [ :x | rv add: (self getSpriteAt: x @ y) ] ].
	^ rv
]

{ #category : #accessing }
SpriteSheet >> sheet [
	^sheet
]

{ #category : #accessing }
SpriteSheet >> sheet: s [
	sheet := s.
	spriteWidth := sheet width.
	spriteHeight := sheet height
]

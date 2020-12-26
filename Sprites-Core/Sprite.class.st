Class {
	#name : #Sprite,
	#superclass : #Morph,
	#instVars : [
		'name',
		'frames'
	],
	#category : #'Sprites-Core'
}

{ #category : #accessing }
Sprite >> initialize [
	super initialize.
	frames := OrderedCollection new.
]

{ #category : #accessing }
Sprite >> name: n [
	name := n
]

Class {
	#name : #SpriteSelectedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'form',
		'pos'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
SpriteSelectedAnnouncement >> form [
	^form
]

{ #category : #accessing }
SpriteSelectedAnnouncement >> form: aForm [
	form := aForm
]

{ #category : #accessing }
SpriteSelectedAnnouncement >> pos [
	^ pos
]

{ #category : #accessing }
SpriteSelectedAnnouncement >> pos: aPos [ 
	pos := aPos
]

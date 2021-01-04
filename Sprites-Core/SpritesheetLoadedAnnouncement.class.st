Class {
	#name : #SpritesheetLoadedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'sheet'
	],
	#category : #'Sprites-Core-Sprites-Core'
}

{ #category : #accessing }
SpritesheetLoadedAnnouncement >> sheet [
	^sheet
]

{ #category : #accessing }
SpritesheetLoadedAnnouncement >> sheet: s [
	^sheet := s
]

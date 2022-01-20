"
A CTSkipListTest is a test class for testing the behavior of CTSkipList
"
Class {
	#name : #CTSkipListTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting',
	#classTraits : 'TIceImagesExporting classTrait',
	#category : #'Containers-SkipList-Tests'
}

{ #category : #tests }
CTSkipListTest >> sutCrescenzi [

	| collection |
	collection := #( 5 10 16 18 30 41 80 ) asSortedCollection: #<.

	^ CTSkipList
		  onSortedCollection: collection
		  lowerBound: Float negativeInfinity
		  upperBound: Float infinity
]

{ #category : #tests }
CTSkipListTest >> testCrescenzi [

	self exportSlotsGraphOf: self sutCrescenzi
]

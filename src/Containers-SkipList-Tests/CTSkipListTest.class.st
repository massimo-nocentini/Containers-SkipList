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
CTSkipListTest >> testCrescenzi [

	| collection skiplist |
	collection := #( 5 10 16 18 30 41 80 ) asSortedCollection: #<.

	skiplist := CTSkipList
		            onSortedCollection: collection
		            lowerBound: Float negativeInfinity
		            upperBound: Float infinity;
		            yourself.

	^ self exportSlotsGraphOf: skiplist
]

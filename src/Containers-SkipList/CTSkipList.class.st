Class {
	#name : #CTSkipList,
	#superclass : #Object,
	#instVars : [
		'lists',
		'sortBlock',
		'lowerBound',
		'upperBound',
		'random'
	],
	#category : #'Containers-SkipList'
}

{ #category : #creation }
CTSkipList class >> onSortedCollection: aCollection lowerBound: lower upperBound: upper [

	^ self
		  onSortedCollection: aCollection
		  lowerBound: lower
		  upperBound: upper
		  atRandom: ((RandomGeometric seed: 541)
				   p: 0.5;
				   yourself)
]

{ #category : #creation }
CTSkipList class >> onSortedCollection: aCollection lowerBound: lower upperBound: upper atRandom: aRandom [

	| brgc lists cleanLists lowerJust upperJust times nothingObject |
	nothingObject := CTCategory maybe nothing.
	lowerJust := lower asJustMaybeCategory.
	upperJust := upper asJustMaybeCategory.

	brgc := aCollection size asBRGCCollection.

	lists := nil.

	times := aCollection
		         ifEmpty: [ 0 ]
		         ifNotEmpty: [ (aCollection size log: 2) floor + 1 ].

	times timesRepeat: [ 
		| list link nextLinkSafe |
		link := lists value.

		nextLinkSafe := [ link := link ifNotNil: [ link nextLink ] ].

		list := CTDoubleValueLink new
			        value: lowerJust;
			        previousLink: link;
			        nextLink: nil;
			        yourself.

		nextLinkSafe value.

		aCollection withIndexDo: [ :each :index | 
			| left eachForList |
			left := brgc at: index.

			eachForList := left > 0
				               ifTrue: [ each asJustMaybeCategory ]
				               ifFalse: [ nothingObject ].

			brgc at: index put: left - 1.

			list := CTDoubleValueLink new
				        value: eachForList;
				        previousLink: link;
				        nextLink: list;
				        yourself.

			nextLinkSafe value ].

		list := CTDoubleValueLink new
			        value: upperJust;
			        previousLink: link;
			        nextLink: list;
			        yourself.

		nextLinkSafe value.

		self assert: link isNil.

		lists := list reversed ~~> lists ].

	cleanLists := lists.

	[ cleanLists ] whileNotNil: [ 
		| list |
		list := cleanLists value.

		[ list ] whileNotNil: [ 
			| each |
			each := list nextLink.

			[ each value == nothingObject ] whileTrue: [ each := each nextLink ].

			list := list
				        value: list value argument;
				        nextLink: each;
				        nextLink ].

		cleanLists := cleanLists nextLink ].


	^ self new
		  lists: lists;
		  sortBlock: aCollection sortBlock;
		  lowerBound: lower;
		  upperBound: upper;
		  random: aRandom;
		  yourself
]

{ #category : #accessing }
CTSkipList >> add: key [

	^ self add: key atHeight: random next
]

{ #category : #accessing }
CTSkipList >> add: key atHeight: r [

	| predecessors height newLink |
	predecessors := self predecessors: key.

	height := self height.

	newLink := self
		           add: key
		           atHeight: (r min: height)
		           predecessors: predecessors.

	r > height ifTrue: [ 
		| newList list |
		list := lists value.

		newList := CTDoubleValueLink new
			           value: lowerBound;
			           previousLink: list;
			           nextLink: (CTDoubleValueLink new
					            value: key;
					            previousLink: newLink;
					            nextLink: (CTDoubleValueLink new
							             value: upperBound;
							             previousLink: (list ifNotNil: [ list last ]);
							             nextLink: nil;
							             yourself);
					            yourself);
			           yourself.

		lists := newList ~~> lists ].

	^ key
]

{ #category : #accessing }
CTSkipList >> add: key atHeight: r predecessors: aLink [

	| newLink predecessors |
	predecessors := aLink.
	newLink := nil.

	r timesRepeat: [ 
		| predecessor |
		predecessor := predecessors value.

		newLink := CTDoubleValueLink new
			           value: key;
			           previousLink: newLink;
			           nextLink: predecessor nextLink;
			           yourself.

		predecessor nextLink: newLink.

		predecessors := predecessors nextLink ].

	^ newLink
]

{ #category : #accessing }
CTSkipList >> height [

	^ lists sizeBlock: [ :link | link nextLink ]
]

{ #category : #testing }
CTSkipList >> includes: aKey equalityBlock: eqBlock [

	| link |
	link := (self predecessors: aKey) value.
	^ eqBlock value: link nextLink value value: aKey
]

{ #category : #accessing }
CTSkipList >> lists: anObject [

	lists := anObject
]

{ #category : #accessing }
CTSkipList >> lowerBound: anObject [

	lowerBound := anObject
]

{ #category : #accessing }
CTSkipList >> predecessors: key [

	| link predecessors |
	predecessors := nil.
	link := lists value.

	[ link ] whileNotNil: [ 
		[ sortBlock value: link nextLink value value: key ] whileTrue: [ 
			link := link nextLink ].

		predecessors := link ~~> predecessors.

		link := link previousLink ].

	^ predecessors
]

{ #category : #accessing }
CTSkipList >> random: anObject [

	random := anObject
]

{ #category : #accessing }
CTSkipList >> sortBlock: anObject [

	sortBlock := anObject
]

{ #category : #accessing }
CTSkipList >> upperBound: anObject [

	upperBound := anObject
]

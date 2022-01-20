"
A CTSkipListTest is a test class for testing the behavior of CTSkipList
"
Class {
	#name : #CTSkipListTest,
	#superclass : #TestCase,
	#traits : 'TIceImagesExporting + MTTProfilingCopying + MTTUmlSequenceDiagramBuilderWithOutliners',
	#classTraits : 'TIceImagesExporting classTrait + MTTProfilingCopying classTrait + MTTUmlSequenceDiagramBuilderWithOutliners classTrait',
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

{ #category : #tests }
CTSkipListTest >> testInspectSkipList [

	^ self
		  compiledMethods: { 
				  (CTSkipList >> #add:).
				  (CTSkipList >> #add:atHeight:).
				  (CTSkipList >> #add:atHeight:predecessors:) }
		  wrapping: [ 
			  self sutCrescenzi
				  add: 35 atHeight: 4;
				  yourself ]
		  then: [ :skiplist :observedData | 
			  | presenter tree builder |
			  tree := observedData tree.

			  builder := self umlSequenceDiagramBuilder:
				             RSUMLSequenceBuilder new.

			  presenter := (MTOverviewSpPresenter on: observedData)
				               umlSequenceDiagramBuilder: builder;
				               openWithSpec;
				               yourself.

			  "self
				  assert: tree size equals: 18;
				  assert: inversions equals: { 
						  (1 -> 2).
						  (1 -> 4).
						  (3 -> 4) }.
"
			  "The count for #nextPut:inversion: equals the count of inversions."
			  "self
				  assert:
				  (observedData statistics at: Stream >> #nextPut:inversion:)
					  count
				  equals: inversions size."

			  self
				  exportShapeOf: tree
				  accessorBlock: [ :aTree | 
					  aTree
						  asShapeUMLSequenceDiagram: builder
						  metadata: observedData metadata ]
				  pathSuffix: 'sequence-diagram'.

			  self exportSlotsGraphOf: skiplist ]
]

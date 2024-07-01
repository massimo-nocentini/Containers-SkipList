"
A CTSkipListTest is a test class for testing the behavior of CTSkipList
"
Class {
	#name : 'CTSkipListTest',
	#superclass : 'TestCase',
	#traits : 'TIceImagesExporting + MTTProfilingCopying + MTTUmlSequenceDiagramBuilderWithOutliners',
	#classTraits : 'TIceImagesExporting classTrait + MTTProfilingCopying classTrait + MTTUmlSequenceDiagramBuilderWithOutliners classTrait',
	#category : 'Containers-SkipList-Tests',
	#package : 'Containers-SkipList-Tests'
}

{ #category : 'tests' }
CTSkipListTest >> sutCrescenzi [

	| collection |
	collection := #( 5 10 16 18 30 41 80 ) asSortedCollection: #<.

	^ CTSkipList
		  onSortedCollection: collection
		  lowerBound: Float negativeInfinity
		  upperBound: Float infinity
]

{ #category : 'tests' }
CTSkipListTest >> testCrescenzi [

	self exportSlotsGraphOf: self sutCrescenzi
]

{ #category : 'tests' }
CTSkipListTest >> testInspectBigList [

	| elements random skiplist n |
	random := Random seed: Number firstCarmichaelNumber.
	n := 100.
	elements := (1 to: n) asArray
		            shuffleBy: random;
		            yourself.

	skiplist := elements
		            inject: (CTSkipList
				             onSortedCollection: (SortedCollection sortUsing: #<)
				             lowerBound: Float negativeInfinity
				             upperBound: Float infinity)
		            into: [ :aSkiplist :each |
			            aSkiplist
				            add: each;
				            yourself ].

	self exportShapeOf: skiplist accessorBlock: #asShapeListWithOutliners.

	self exportSlotsGraphOf: n pathSuffix: 'n'
]

{ #category : 'tests' }
CTSkipListTest >> testProfileAddingFromScratch [

	| elements random |
	random := Random seed: Number firstCarmichaelNumber.
	elements := (1 to: 10) asArray
		            shuffleBy: random;
		            yourself.

	^ self
		  compiledMethods: {
				  (CTSkipList >> #add:).
				  (CTSkipList >> #add:atHeight:).
				  (CTSkipList >> #add:atHeight:predecessors:) }
		  wrapping: [
			  elements
				  inject: (CTSkipList
						   onSortedCollection: (SortedCollection sortUsing: #<)
						   lowerBound: Float negativeInfinity
						   upperBound: Float infinity)
				  into: [ :skiplist :each |
					  skiplist
						  add: each;
						  yourself ] ]
		  then: [ :skiplist :observedData |
			  | presenter tree builder |
			  tree := observedData tree.

			  builder := self umlSequenceDiagramBuilder:
				             RSUMLSequenceBuilder new.

			  presenter := (MTOverviewSpPresenter on: observedData)
				               umlSequenceDiagramBuilder: builder;
				               open;
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

			  self
				  exportSlotsGraphOf: skiplist;
				  exportSlotsGraphOf: elements pathSuffix: 'elements' ]
]

{ #category : 'tests' }
CTSkipListTest >> testProfileAdditionOf35 [

	| key |
	key := 35.
	^ self
		  compiledMethods: { 
				  (CTSkipList >> #add:).
				  (CTSkipList >> #add:atHeight:).
				  (CTSkipList >> #add:atHeight:predecessors:) }
		  wrapping: [ 
			  self sutCrescenzi
				  add: key atHeight: 4;
				  yourself ]
		  then: [ :skiplist :observedData | 
			  | presenter tree builder |
			  tree := observedData tree.

			  builder := self umlSequenceDiagramBuilder:
				             RSUMLSequenceBuilder new.

			  presenter := (MTOverviewSpPresenter on: observedData)
				               umlSequenceDiagramBuilder: builder;
				               open;
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

			  self
				  exportSlotsGraphOf: skiplist;
				  exportSlotsGraphOf: key pathSuffix: 'key' ]
]

{ #category : 'tests' }
CTSkipListTest >> testProfileInclusion [

	| skipList key |
	skipList := self sutCrescenzi.
	key := 80.

	^ self
		  compiledMethods: { 
				  (CTDoubleValueLink >> #previousLink).
				  (Link >> #nextLink).
				  (CTSkipList >> #includes:equalityBlock:).
				  (CTSkipList >> #predecessors:) }
		  wrapping: [ 
			  skipList
				  includes: key
				  equalityBlock: [ :each :another | each = another ] ]
		  then: [ :aBoolean :observedData | 
			  | presenter tree builder |
			  tree := observedData tree.

			  builder := self umlSequenceDiagramBuilder:
				             RSUMLSequenceBuilder new.

			  presenter := (MTOverviewSpPresenter on: observedData)
				               umlSequenceDiagramBuilder: builder;
				               open;
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

			  self
				  exportSlotsGraphOf: aBoolean;
				  exportSlotsGraphOf: key pathSuffix: 'key' ]
]

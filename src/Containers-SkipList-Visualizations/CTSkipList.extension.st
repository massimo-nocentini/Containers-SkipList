Extension { #name : #CTSkipList }

{ #category : #'*Containers-SkipList-Visualizations' }
CTSkipList >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitSkipList: self
]

{ #category : #'*Containers-SkipList-Visualizations' }
CTSkipList >> asShapeList: shapeBlock [

	| shapes relation ordered edges lineBuilder count height colors |
	ordered := OrderedCollection new.
	edges := OrderedCollection new.
	shapes := IdentityDictionary new.
	relation := IdentityDictionary new.

	count := IdentityDictionary new.

	height := self height.

	colors := NSScale ordinalColored: height.

	lists reversed do: [ :list | 
		| each value c |
		each := list.
		[ 
		value := each value.

		c := count at: value ifAbsent: [ 0 ].
		count at: value put: c + 1.

		shapes at: value ifAbsentPut: [ 
			| shape |
			shape := shapeBlock value: value.
			ordered add: shape.
			shape
				draggable;
				yourself ].

		each nextLink ] whileNotNil: [ 
			| rel nextValue |
			nextValue := each nextLink value.
			rel := relation at: value ifAbsentPut: [ IdentitySet new ].
			rel add: nextValue -> rel size.
			each := each nextLink ] ].

	lineBuilder := RSLineBuilder directedBezier
		               withVerticalAttachPoint;
		               yourself.

	RSVerticalLineLayout new
		alignCenter;
		applyOn: ordered.

	relation keysAndValuesDo: [ :key :neighborhood | 
		neighborhood do: [ :anAssoc | 
			| edge |
			edge := lineBuilder
				        edgeFrom: (shapes at: key)
				        to: (shapes at: anAssoc key).
			"height - anAssoc value + 1 timesRepeat: [ 
				edge color: edge color lighter ]."
			edge color: (colors scale: anAssoc value).
			edge width: anAssoc value + 1 * Float goldenRatio.
			edges add: edge ] ].

	^ RSComposite new
		  model: self;
		  shapes: ordered , edges;
		  yourself
]

{ #category : #'*Containers-SkipList-Visualizations' }
CTSkipList >> asShapeListWithOutliners [

	^ self asShapeList: [ :each | 
		  each asShapeSlotsDfsTree: each slotDescriptorsContext ]
]

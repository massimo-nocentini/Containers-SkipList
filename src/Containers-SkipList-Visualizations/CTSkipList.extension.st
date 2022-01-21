Extension { #name : #CTSkipList }

{ #category : #'*Containers-SkipList-Visualizations' }
CTSkipList >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitSkipList: self
]

{ #category : #'*Containers-SkipList-Visualizations' }
CTSkipList >> asShapeList: shapeBlock [

	| shapes relation ordered edges lineBuilder |
	ordered := OrderedCollection new.
	edges := OrderedCollection new.
	shapes := IdentityDictionary new.
	relation := IdentityDictionary new.

	lists reversed do: [ :list | 
		| each value |
		each := list.
		[ 
		value := each value.

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
			rel add: nextValue.
			each := each nextLink ] ].

	lineBuilder := RSLineBuilder directedBezier
		               withVerticalAttachPoint;
		               yourself.

	RSVerticalLineLayout new
		alignCenter;
		applyOn: ordered.

	relation keysAndValuesDo: [ :key :neighborhood | 
		neighborhood do: [ :each | 
			edges add:
				(lineBuilder edgeFrom: (shapes at: key) to: (shapes at: each)) ] ].

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

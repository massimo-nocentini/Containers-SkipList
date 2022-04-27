Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-SkipList-Visualizations' }
CTSlotDescriptorsVisitor >> visitSkipList: aSkipList [

	^ (self visitObject: aSkipList) , { 
		  (self newSlotDescriptorSelector: #height).
		  ((self newSlotDescriptorSelector: #asShapeListWithOutliners:)
			   inline;
			   quote) }
]

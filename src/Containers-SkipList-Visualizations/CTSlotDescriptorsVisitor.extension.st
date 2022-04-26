Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-SkipList-Visualizations' }
CTSlotDescriptorsVisitor >> visitSkipList: aSkipList [

	^ (self visitObject: aSkipList) , { 
		  (self newSlotDescriptor selector: #height).
		  (self newSlotDescriptor
			   selector: #asShapeListWithOutliners:;
			   inline;
			   quote) }
]

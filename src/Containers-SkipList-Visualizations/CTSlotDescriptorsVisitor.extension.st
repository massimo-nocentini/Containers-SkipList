Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-SkipList-Visualizations' }
CTSlotDescriptorsVisitor >> visitSkipList: aSkipList [

	^ (self visitObject: aSkipList) , { 
		  (self newSlotDescriptorSelector selector: #height).
		  (self newSlotDescriptorSelector
			   selector: #asShapeListWithOutliners:;
			   inline;
			   quote) }
]

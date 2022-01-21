Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-SkipList-Visualizations' }
CTSlotDescriptorsVisitor >> visitSkipList: aSkipList [

	^ (self visitObject: aSkipList) , { 
		  #height asSlotDescriptor.
		  (#asShapeListWithOutliners asSlotDescriptor
			   inline: true;
			   quote) }
]

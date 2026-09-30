Extension { #name : 'RMDDirectionOfMaximumInEightNeighborsDirectiveNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDDirectionOfMaximumInEightNeighborsDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  directive: 'direction maximum'
		  attribute: self patchAttributeVariable identifier
		  suffix: 'among eight neighbors'
]

Extension { #name : 'RMDDirectionOfMaximumInFourNeighborsDirectiveNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDDirectionOfMaximumInFourNeighborsDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  directive: 'direction maximum'
		  attribute: self patchAttributeVariable identifier
		suffix: 'among four neighbors'
]

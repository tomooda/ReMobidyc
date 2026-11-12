Extension { #name : 'RMDDirectionOfMaximumNeighborDirectiveNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDDirectionOfMaximumNeighborDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode directive: 'direction maximum' attribute: self patchAttributeVariable identifier suffix: 'neighbor'
]

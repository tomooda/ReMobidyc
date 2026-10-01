Extension { #name : 'RMDDirectionOfMaximumInRadiusDirectiveNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> asPrettyPrintNode [

	^ RMDPrettyPrintNode
		  directive: 'direction maximum'
		  attribute: self patchAttributeVariable identifier
		  keyword: 'in'
		  expression: radius asPrettyPrintNode
		  suffix: 'radius'
]

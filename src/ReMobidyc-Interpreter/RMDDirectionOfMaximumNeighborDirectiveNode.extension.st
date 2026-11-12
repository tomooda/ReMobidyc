Extension { #name : 'RMDDirectionOfMaximumNeighborDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDirectionOfMaximumNeighborDirectiveNode >> evalIn: aRMDInterpreter [

	| attribute best direction |
	patchAttributeVariable isPlaceholderNode ifTrue: [ ^ RMDUnresolvedPlaceholderError signal: patchAttributeVariable ].
	attribute := patchAttributeVariable identifier.
	best := aRMDInterpreter heres: attribute.
	direction := nil.
	aRMDInterpreter neighborsAndVectorsDo: [ :patch :vector |
			| v |
			v := aRMDInterpreter readAttribute: attribute patch: patch.
			best < v ifTrue: [
					best := v.
					direction := vector ] ].
	^ direction ifNotNil: [ ((direction at: 1) @ (direction at: 2)) theta ] ifNil: [ aRMDInterpreter random * 2.0 * Float pi ]
]

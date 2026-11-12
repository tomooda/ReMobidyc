Extension { #name : 'RMDDirectionOfGradientDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDirectionOfGradientDirectiveNode >> evalIn: aRMDInterpreter [

	| attribute here vx vy |
	patchAttributeVariable isPlaceholderNode ifTrue: [ ^ RMDUnresolvedPlaceholderError signal: patchAttributeVariable ].
	attribute := patchAttributeVariable identifier.
	here := aRMDInterpreter heres: attribute.
	vx := 0.0.
	vy := 0.0.
	aRMDInterpreter neighborsAndVectorsDo: [ :patch :vector |
			| v |
			v := (aRMDInterpreter readAttribute: attribute patch: patch) - here.
			vx := v * (vector at: 1) + vx.
			vy := v * (vector at: 2) + vy ].
	^ (vx isZero and: [ vy isZero ])
		  ifTrue: [ aRMDInterpreter random * 2.0 * Float pi ]
		  ifFalse: [ (vx @ vy) theta ifNanOrInfinite: [ RMDNotComputableError signal: self ] ]
]

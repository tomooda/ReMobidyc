Extension { #name : 'RMDDirectionOfMaximumInRadiusDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> evalIn: aRMDInterpreter [

	| attributeOffset x y range best bestPatch |
	patchAttributeVariable isPlaceholderNode ifTrue: [ ^ RMDUnresolvedPlaceholderError signal: patchAttributeVariable ].
	attributeOffset := aRMDInterpreter context locationDefinition
		                   offsetAt: patchAttributeVariable identifier
		                   ifAbsent: [ RMDUndefinedAttributeError signal: patchAttributeVariable ].
	x := aRMDInterpreter my: 'x'.
	y := aRMDInterpreter my: 'y'.
	range := radius evalIn: aRMDInterpreter.
	best := aRMDInterpreter
		        read: aRMDInterpreter context location + attributeOffset
		        ifAbsent: [ RMDAddressError signal: patchAttributeVariable ].
	bestPatch := nil.
	aRMDInterpreter
		patchesWithin: range
		fromX: x
		y: y
		do: [ :patch |
				| value |
				value := aRMDInterpreter read: patch + attributeOffset ifAbsent: [ RMDAddressError signal: patchAttributeVariable ].
				best < value ifTrue: [
						best := value.
						bestPatch := patch ] ].
	^ bestPatch
		  ifNil: [ aRMDInterpreter random * 2.0 * Float pi ]
		  ifNotNil: [ ((aRMDInterpreter centerXOfPatch: bestPatch) @ (aRMDInterpreter centerYOfPatch: bestPatch) - (x @ y)) theta ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDDirectionOfMaximumInRadiusDirectiveNode >> typecheckIn: aRMDInterpreter [

	radius isPlaceholderNode ifTrue: [ ^ RMDUnresolvedPlaceholderError signal: radius ].
	self typecheck: radius with: RMDType length in: aRMDInterpreter.
	^ super typecheckIn: aRMDInterpreter
]
